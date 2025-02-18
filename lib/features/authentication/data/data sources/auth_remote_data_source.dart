import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/util/model/user_info.dart';

abstract class AuthRemoteData {
  Future<DataState<UserEntity>> signUpUser({
    required AppUserCubit appUserCubit,
    required UserEntity user,
    required String confirmPassword,
  });

  Future<DataState<UserEntity>> loginUser({
    required AppUserCubit appUserCubit,
    required String email,
    required String password,
  });
}

class AuthRemoteDataImpl implements AuthRemoteData {
  @override
  Future<DataState<UserEntity>> loginUser({
    required AppUserCubit appUserCubit,
    required String email,
    required String password,
  }) async {
    if (email == "" || password == "") {
      return const DataFailed("Fill all the information to continue");
    }
    try {
      UserModel userData = UserModel();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      FirebaseFirestore db = FirebaseFirestore.instance;

      final snapshot1 =
          await db.collection("student").where("email", isEqualTo: email).get();
      final snapshot2 =
          await db.collection("teacher").where("email", isEqualTo: email).get();

      bool verified = FirebaseAuth.instance.currentUser!.emailVerified;

      if (snapshot1.docs.isNotEmpty) {
        userData = snapshot1.docs.map((e) => UserModel.fromSnapshot(e)).single;
      } else if (snapshot2.docs.isNotEmpty) {
        userData = snapshot2.docs.map((e) => UserModel.fromSnapshot(e)).single;
      } else {
        return const DataFailed("User Data Not Found");
      }

      if (verified) {
        if (!userData.verified!) {
          await FirebaseFirestore.instance
              .collection(userData.user == "Student" ? "student" : "teacher")
              .doc(userData.docID)
              .update({'verified': true});
        }
        await appUserCubit.updateUser();
      }
      return DataSuccess(userData);
    } on FirebaseAuthException catch (e) {
      return DataFailed(e.code);
    }
  }

  @override
  Future<DataState<UserEntity>> signUpUser({
    required AppUserCubit appUserCubit,
    required UserEntity user,
    required String confirmPassword,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final bool isStudent = user.user == "Student";

    if (isStudent) {
      if (user.name == "" ||
          user.batch == "" ||
          user.section == "" ||
          user.studentID == "" ||
          user.faculty == "" ||
          user.department == "" ||
          user.email == "" ||
          user.password == "" ||
          confirmPassword == "") {
        return const DataFailed("Fill all the information to continue");
      }
    } else {
      if (user.name == "" ||
          user.ti == "" ||
          user.faculty == "" ||
          user.department == "" ||
          user.email == "" ||
          user.password == "" ||
          confirmPassword == "") {
        return const DataFailed("Fill all the information to continue");
      }
    }

    if (user.password != confirmPassword) {
      return DataFailed("Password didn't match");
    }
    if (user.email!.endsWith("@diu.edu.bd") ||
        user.email!.endsWith("@daffodilvarsity.edu.bd")) {
      if (user.password!.length < 8) {
        return const DataFailed("Enter a strong password");
      }
    } else {
      return const DataFailed("Enter a valid DIU mail");
    }

    try {
      await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      CollectionReference collRef = FirebaseFirestore.instance
          .collection(isStudent ? 'student' : 'teacher');
      Map<String, dynamic> studentUserData = {
        'user': "Student",
        'name': user.name,
        'batch': user.batch,
        'section': user.section,
        'studentID': user.studentID,
        'faculty': user.faculty,
        'department': user.department,
        'email': user.email,
        'password': user.password,
        'verified': false
      };
      Map<String, dynamic> teacherUserData = {
        'user': "Teacher",
        'name': user.name,
        'ti': user.ti,
        'faculty': user.faculty,
        'department': user.department,
        'email': user.email,
        'password': user.password,
        'verified': false
      };

      late String docID;
      await collRef
          .add(isStudent ? studentUserData : teacherUserData)
          .then((doc) {
        docID = doc.id;
      });
      UserModel newUser = UserModel(
        user: user.user,
        name: user.name,
        email: user.email,
        docID: docID,
        faculty: user.faculty,
        department: user.department,
        batch: user.batch,
        section: user.section,
        studentID: user.studentID,
        ti: user.ti,
        password: user.password,
        verified: false,
      );
      return DataSuccess(newUser);
    } on FirebaseAuthException catch (e) {
      return DataFailed(e.code.toString());
    } on FirebaseException catch (e) {
      return DataFailed(e.code.toString());
    }
  }
}
