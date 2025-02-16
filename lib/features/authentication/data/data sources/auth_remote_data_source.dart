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
        return DataSuccess(userData);
      } else {
        return const DataFailed("User not verified");
      }
    } on FirebaseAuthException catch (e) {
      return DataFailed(e.code);
    }
  }

  @override
  Future<DataState<UserEntity>> signUpUser({
    required AppUserCubit appUserCubit,
    required UserEntity user,
  }) {
    // TODO: implement signUpUser
    throw UnimplementedError();
  }
}
