import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mca_app_1/Repository/Database/chatModel.dart';

import '../Authentication/authRepository.dart';

class ChatRepository extends GetxController {
  static ChatRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createChat(ChatModel chat) async {
    await _db.collection("Chats").add(chat.toJson());
  }

  Future<List<String>> getChats() async {
    List<String> chats = [];
    final snapshot = await _db.collection("Chats").get();
    final chatData = snapshot.docs
        .forEach((DocumentSnapshot<Map<String, dynamic>> document) {
      String sender = document.data()!['sender'];
      String receiver = document.data()!['receiver'];
      if (!chats.contains(receiver) &&
          sender == AuthRepository.instance.firebaseUser.value!.email) {
        chats.add(receiver);
      } else if (!chats.contains(sender) &&
          receiver == AuthRepository.instance.firebaseUser.value!.email) {
        chats.add(sender);
      }
    });
    return chats;
  }

  Stream<List<String>> getUserChats() {
    return _db
        .collection("Chats")
        .orderBy("time", descending: true)
        .snapshots()
        .map((snapshot) {
      List<String> chats = [];
      snapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> document) {
        String sender = document.data()!['sender'];
        String receiver = document.data()!['receiver'];
        if (!chats.contains(receiver) &&
            sender == AuthRepository.instance.firebaseUser.value!.email) {
          chats.add(receiver);
        } else if (!chats.contains(sender) &&
            receiver == AuthRepository.instance.firebaseUser.value!.email) {
          chats.add(sender);
        }
      });
      return chats;
    });
  }
}
