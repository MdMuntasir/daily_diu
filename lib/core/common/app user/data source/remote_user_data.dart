import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../resources/data_state.dart';
import '../../../util/model/user_info.dart';

abstract class RemoteUserData {
  Future<DataState<UserModel>> userData();
}

class RemoteUserDataImpl implements RemoteUserData {
  User? user;
  FirebaseFirestore firestore;

  RemoteUserDataImpl(this.user, this.firestore);

  @override
  Future<DataState<UserModel>> userData() async {
    await user?.reload();

    final snapshot1 = await firestore
        .collection("student")
        .where("email", isEqualTo: user?.email)
        .get();
    final snapshot2 = await firestore
        .collection("teacher")
        .where("email", isEqualTo: user?.email)
        .get();

    if (snapshot1.docs.isNotEmpty) {
      UserModel userData = snapshot1.docs
          .map((snapshot) => UserModel.fromSnapshot(snapshot))
          .single;
      return DataSuccess(userData);
    } else if (snapshot2.docs.isNotEmpty) {
      UserModel userData = snapshot2.docs
          .map((snapshot) => UserModel.fromSnapshot(snapshot))
          .single;
      return DataSuccess(userData);
    } else {
      return const DataFailed("No Data Found");
    }
  }
}
