import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? id;
  final String sender;
  final String receiver;
  final String chatData;
  final Timestamp time;

  const ChatModel({
    this.id,
    required this.sender,
    required this.receiver,
    required this.chatData,
    required this.time,
  });

  toJson() {
    return {
      "sender": sender,
      "receiver": receiver,
      "chatData": chatData,
      "time": time,
    };
  }

  factory ChatModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ChatModel(
      id: document.id,
      sender: data["sender"],
      receiver: data["receiver"],
      chatData: data["chatData"],
      time: data["time"],
    );
  }
}
