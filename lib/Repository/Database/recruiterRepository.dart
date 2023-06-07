import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';

class RecruiterRepository extends GetxController {
  static RecruiterRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createRecruiter(RecruiterModel user) async {
    await _db.collection("Recruiters").add(user.toJson()).whenComplete(() {
      print("success");
    });
  }

  Stream<RecruiterModel> getRecruiterDetails() {
    final email = AuthRepository.instance.firebaseUser.value?.email;
    return _db
        .collection("Recruiters")
        .where("email", isEqualTo: email)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => RecruiterModel.fromSnapshot(e)).single);
  }

  Future<void> updateRecruiterRecord(RecruiterModel user) async {
    await _db.collection("Recruiters").doc(user.id).update(user.toJson());
  }

  Stream<List<RecruiterModel>> getRecruiters() {
    return _db.collection("Recruiters").snapshots().map((snapshot) => snapshot
        .docs
        .map((e) => RecruiterModel.fromSnapshot(e))
        .where((user) =>
            user.requirements != "" &&
            user.phone != "" &&
            user.address != "" &&
            user.company != "" &&
            user.verified == "verified" &&
            user.vacancy != "")
        .toList());
  }

  Stream<List<String>> getCompanies() {
    return _db.collection("Recruiters").snapshots().map((snapshot) {
      List<String> companies = [];
      final companyData = snapshot.docs
          .forEach((DocumentSnapshot<Map<String, dynamic>> document) {
        String company = document.data()!['company'];
        if (!companies.contains(company) && company != "") {
          companies.add(company);
        }
      });
      return companies;
    });
  }
}
