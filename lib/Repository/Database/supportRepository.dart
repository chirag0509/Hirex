import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/Database/supportModel.dart';

class SupportRepository extends GetxController {
  static SupportRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createApplication(SupportModel user) async {
    await _db
        .collection("Support")
        .add(user.toJson())
        .then((_) => Get.snackbar("Success", "Message sent successfully"));
  }

  Stream<List<SupportModel>> getSupport() {
    return _db.collection("Support").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => SupportModel.fromSnapshot(e)).toList());
  }
}
