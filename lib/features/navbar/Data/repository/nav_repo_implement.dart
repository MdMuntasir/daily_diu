import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/navbar/Domain/repository/nav_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class NavRepoImpl implements NavRepository {
  final AppUserCubit appUserCubit;
  final Box box;

  NavRepoImpl(this.box, this.appUserCubit);

  @override
  Future<DataState> editProfile() {
    // TODO: implement editProfile
    throw UnimplementedError();
  }

  @override
  Future<DataState> signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((_) async {
        await box.clear();
        await appUserCubit.updateUser();
      });
      return const DataSuccess("Signed Out");
    } on FirebaseException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
