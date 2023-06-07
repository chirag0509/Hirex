import 'package:cloud_firestore/cloud_firestore.dart';

class SupportModel {
  final String id;
  final String name;
  final String email;
  final String subject;
  final String message;

  const SupportModel({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });

  toJson() {
    return {
      "name": name,
      "email": email,
      "subject": subject,
      "message": message,
    };
  }

  factory SupportModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return SupportModel(
      id: document.id,
      name: data["name"],
      email: data["email"],
      subject: data["subject"],
      message: data["message"],
    );
  }
}
