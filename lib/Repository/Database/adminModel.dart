import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String image;
  final int createdUser;
  final int createdRecruiter;
  final int createdAdmin;
  final int deletedUser;
  final int deletedRecruiter;
  final int deletedAdmin;

  const AdminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.createdUser,
    required this.createdAdmin,
    required this.createdRecruiter,
    required this.deletedAdmin,
    required this.deletedRecruiter,
    required this.deletedUser,
  });

  toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "image": image,
      "createdUser": createdUser,
      "createdAdmin": createdAdmin,
      "createdRecruiter": createdRecruiter,
      "deletedAdmin": deletedAdmin,
      "deletedRecruiter": deletedRecruiter,
      "deletedUser": deletedUser,
    };
  }

  factory AdminModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AdminModel(
      id: document.id,
      name: data["name"],
      email: data["email"],
      password: data["password"],
      image: data["image"],
      deletedAdmin: data["deletedAdmin"],
      deletedRecruiter: data["deletedRecruiter"],
      deletedUser: data["deletedUser"],
      createdAdmin: data["createdAdmin"],
      createdRecruiter: data["createdRecruiter"],
      createdUser: data["createdUser"],
    );
  }
}
