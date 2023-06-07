import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/adminModel.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/supportModel.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';

class AdminRepository extends GetxController {
  static AdminRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Stream<List<RecruiterModel>> getRecruiters() {
    return _db.collection("Recruiters").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => RecruiterModel.fromSnapshot(e)).toList());
  }

  Stream<List<UserModel>> getUsers() {
    return _db.collection("Users").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  Stream<List<AdminModel>> getAdmins() {
    return _db.collection("Admins").snapshots().map((snapshot) => snapshot.docs
        .map((e) => AdminModel.fromSnapshot(e))
        .where((user) =>
            user.email != AuthRepository.instance.firebaseUser.value!.email)
        .toList());
  }

  Stream<AdminModel> getAdminDetails() {
    final email = AuthRepository.instance.firebaseUser.value?.email;
    return _db
        .collection("Admins")
        .where("email", isEqualTo: email)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => AdminModel.fromSnapshot(e)).single);
  }

  createAdmin(AdminModel user) async {
    await _db.collection("Admins").add(user.toJson()).whenComplete(() {
      print("success");
    });
  }

  Future<void> updateReAdminRecord(AdminModel user) async {
    await _db.collection("Admins").doc(user.id).update(user.toJson());
  }

}
