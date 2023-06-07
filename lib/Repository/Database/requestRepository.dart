import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/requestModel.dart';

class RequestRepository extends GetxController {
  static RequestRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createRequest(RequestModel request) async {
    final documentReference =
        await _db.collection("Requests").add(request.toJson()).whenComplete(() {
      Get.snackbar("Success", "Request Sent Successfully");
    });
    request.id = documentReference.id;
  }

  Stream<List<RequestModel>> getSentRequest() {
    return _db.collection("Requests").snapshots().map((snapshot) => snapshot
        .docs
        .map((e) => RequestModel.fromSnapshot(e))
        .where((request) =>
            request.sender ==
                AuthRepository.instance.firebaseUser.value!.email &&
            request.status == "pending")
        .toList());
  }

  Stream<List<RequestModel>> getReceivedRequest() {
    return _db.collection("Requests").snapshots().map((snapshot) => snapshot
        .docs
        .map((e) => RequestModel.fromSnapshot(e))
        .where((request) =>
            request.receiver ==
                AuthRepository.instance.firebaseUser.value!.email &&
            request.status == "pending")
        .toList());
  }

  Stream<List<RequestModel>> getAcceptedRequest() {
    return _db.collection("Requests").snapshots().map((snapshot) => snapshot
        .docs
        .map((e) => RequestModel.fromSnapshot(e))
        .where((request) =>
            (request.receiver ==
                    AuthRepository.instance.firebaseUser.value!.email &&
                request.status == "accepted") ||
            (request.sender ==
                    AuthRepository.instance.firebaseUser.value!.email &&
                request.status == "accepted"))
        .toList());
  }

  Future<void> updateRequestRecord(String id, RequestModel request) async {
    final document = _db.collection("Requests").doc(id);
    final snapshot = await document.get();
    if (snapshot.exists) {
      await document.update(request.toJson());
    } else {
      Get.snackbar("Error", "Request not found");
    }
  }
}
