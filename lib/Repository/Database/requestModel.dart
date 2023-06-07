import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  String id;
  final String sender;
  final String receiver;
  final String status;
  final Timestamp time;

  RequestModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.status,
    required this.time,
  });

  toJson() {
    return {
      "sender": sender,
      "receiver": receiver,
      "status": status,
      "time": time,
    };
  }

  factory RequestModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RequestModel(
        id: document.id,
        sender: data["sender"],
        receiver: data["receiver"],
        status: data["status"],
        time: data["time"]);
  }
}
