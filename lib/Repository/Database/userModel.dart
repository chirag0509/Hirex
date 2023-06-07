import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String qualification;
  final String experience;
  final String image;
  final String expertise;
  final List<dynamic>? documents;
  final String verified;
  final String block;

  const UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.address,
      required this.qualification,
      required this.experience,
      required this.image,
      required this.expertise,
      required this.documents,
      required this.block,
      required this.verified});

  toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "qualification": qualification,
      "experience": experience,
      "image": image,
      "documents": documents,
      "expertise": expertise,
      "verified": verified,
      "block": block,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        name: data["name"],
        email: data["email"],
        password: data["password"],
        phone: data["phone"],
        address: data["address"],
        experience: data["experience"],
        image: data["image"],
        expertise: data["expertise"],
        verified: data["verified"],
        documents: data["documents"] as List<dynamic>,
        qualification: data["qualification"],
        block: data["block"]);
  }
}
