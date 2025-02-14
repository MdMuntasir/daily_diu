import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/navbar/Domain/repository/nav_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../../core/Network/connection_checker.dart';

class NavRepoImpl implements NavRepository {
  final AppUserCubit appUserCubit;
  final Box box;

  NavRepoImpl(this.box, this.appUserCubit);

  @override
  Future<DataState> editProfile(UserEntity newUser) async {
    UserEntity currentUser = appUserCubit.currentUser(appUserCubit);
    ConnectionChecker connectionChecker =
        ConnectionCheckerImpl(InternetConnection.createInstance());

    if (await connectionChecker.isConnected) {
      if (currentUser.user == "Student") {
        try {
          await FirebaseFirestore.instance
              .collection("student")
              .doc(currentUser.docID)
              .update({
            'name': newUser.name != "" ? newUser.name : currentUser.name,
            'batch': newUser.batch != "" ? newUser.batch : currentUser.batch,
            'section':
                newUser.section != "" ? newUser.section : currentUser.section,
            'studentID': newUser.studentID != ""
                ? newUser.studentID
                : currentUser.studentID,
            'faculty':
                newUser.faculty != "" ? newUser.faculty : currentUser.faculty,
            'department': newUser.department != ""
                ? newUser.department
                : currentUser.department,
          }).then(
            (value) async {
              await appUserCubit.updateUser();
            },
          );
          return const DataSuccess("Profile Changed Successfully");
        } on FirebaseException catch (e) {
          return DataFailed(e.message.toString());
        }
      } else if (currentUser.user == "Teacher") {
        try {
          await FirebaseFirestore.instance
              .collection("teacher")
              .doc(currentUser.docID)
              .update({
            'name': newUser.name != "" ? newUser.name : currentUser.name,
            'ti': newUser.ti != "" ? newUser.ti : currentUser.ti,
            'faculty':
                newUser.faculty != "" ? newUser.faculty : currentUser.faculty,
            'department': newUser.department != ""
                ? newUser.department
                : currentUser.department,
          }).then(
            (value) async {
              await appUserCubit.updateUser();
            },
          );
          return const DataSuccess("Profile Changed Successfully");
        } on FirebaseException catch (e) {
          return DataFailed(e.message.toString());
        }
      } else {
        return const DataFailed("No User Found");
      }
    } else {
      return const DataFailed("No Internet");
    }
  }

  @override
  Future<DataState> changePassword(String password) async {
    User user = FirebaseAuth.instance.currentUser!;
    UserEntity currentUser = appUserCubit.currentUser(appUserCubit);
    ConnectionChecker connectionChecker =
        ConnectionCheckerImpl(InternetConnection.createInstance());

    if (await connectionChecker.isConnected) {
      if (currentUser.user == "Student") {
        try {
          await user
              .reauthenticateWithCredential(EmailAuthProvider.credential(
                  email: currentUser.email!, password: currentUser.password!))
              .then(
            (_) async {
              await user.updatePassword(password).then(
                (_) {
                  FirebaseFirestore.instance
                      .collection("student")
                      .doc(currentUser.docID!)
                      .update({"password": password}).then(
                          (_) => appUserCubit.updateUser());
                },
              );
            },
          );
          return const DataSuccess("Password Changed Successfully");
        } on FirebaseException catch (e) {
          return DataFailed(e.message.toString());
        }
      } else if (currentUser.user == "Teacher") {
        try {
          await user
              .reauthenticateWithCredential(EmailAuthProvider.credential(
                  email: currentUser.email!, password: currentUser.password!))
              .then(
            (_) async {
              await user.updatePassword(password).then(
                (_) {
                  FirebaseFirestore.instance
                      .collection("teacher")
                      .doc(currentUser.docID!)
                      .update({"password": password}).then(
                          (_) => appUserCubit.updateUser());
                },
              );
            },
          );
          return const DataSuccess("Password Changed Successfully");
        } on FirebaseException catch (e) {
          return DataFailed(e.message.toString());
        }
      } else {
        return const DataFailed("No User Found");
      }
    } else {
      return const DataFailed("No Internet");
    }
  }

  @override
  Future<DataState> signOut() async {
    ConnectionChecker connectionChecker =
        ConnectionCheckerImpl(InternetConnection.createInstance());

    if (await connectionChecker.isConnected) {
      try {
        await FirebaseAuth.instance.signOut().then((_) async {
          await box.clear();
          await appUserCubit.updateUser();
        });
        return const DataSuccess("Signed Out");
      } on FirebaseException catch (e) {
        return DataFailed(e.message.toString());
      }
    } else {
      return const DataFailed("No Internet");
    }
  }
}
