import 'package:cloud_firestore/cloud_firestore.dart';

class RecruiterModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String image;
  final String vacancy;
  final String company;
  final String requirements;
  final String verified;

  RecruiterModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.vacancy,
    required this.image,
    required this.company,
    required this.requirements,
    required this.verified,
  });

  toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "company": company,
      "phone": phone,
      "address": address,
      "vacancy": vacancy,
      "image": image,
      "requirements": requirements,
      "verified": verified,
    };
  }

  factory RecruiterModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RecruiterModel(
      id: document.id,
      name: data["name"],
      email: data["email"],
      password: data["password"],
      phone: data["phone"],
      address: data["address"],
      company: data["company"],
      vacancy: data["vacancy"],
      image: data["image"],
      requirements: data["requirements"],
      verified: data["verified"],
    );
  }
}
