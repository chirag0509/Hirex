import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJson()).whenComplete(() {
      print("success");
    });
  }

  Stream<UserModel> getUserDetails() {
    final email = AuthRepository.instance.firebaseUser.value?.email;
    return _db
        .collection("Users")
        .where("email", isEqualTo: email)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single);
  }

  Future<void> updateUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }

  Stream<List<UserModel>> getUsers() {
    return _db.collection("Users").snapshots().map((snapshot) => snapshot.docs
        .map((e) => UserModel.fromSnapshot(e))
        .where((user) =>
            user.address != "" &&
            user.documents!.length != 0 &&
            user.experience != "" &&
            user.expertise != "" &&
            user.phone != "" &&
            user.verified == "verified" &&
            user.block != "blocked" &&
            user.qualification != "")
        .toList());
  }

  Stream<List<String>> getExpertise() {
    return _db.collection("Users").snapshots().map((snapshot) {
      List<String> expertises = [];
      final expertiseData = snapshot.docs
          .forEach((DocumentSnapshot<Map<String, dynamic>> document) {
        String expertise = document.data()!['expertise'];
        if (!expertises.contains(expertise) && expertise != "") {
          expertises.add(expertise);
        }
      });
      return expertises;
    });
  }
}
