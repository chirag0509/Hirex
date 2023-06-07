import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Admin/adminDashboard.dart';
import 'package:mca_app_1/OffPages/welcomeScreen.dart';
import 'package:mca_app_1/Recruiter/recruiterDashboard.dart';
import 'package:mca_app_1/User/userDashboard.dart';
import 'package:mca_app_1/Repository/AuthScreens/loginScreen.dart';
import 'package:mca_app_1/routes.dart';
import '../../main.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  bool checkEmail = false;

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
  }

  Future<void> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    if (name == "") {
      Get.showSnackbar(GetSnackBar(
        message: 'Please enter a name.',
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 61, 22),
      ));
    } else if (email == "") {
      Get.showSnackbar(GetSnackBar(
        message: 'Please enter an email.',
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 61, 22),
      ));
    } else if (password == "") {
      Get.showSnackbar(GetSnackBar(
        message: 'Please enter a password.',
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 61, 22),
      ));
    } else {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        isSwitched
            ? Get.offAllNamed(RecruiterRoutes.recruiterDashboard)
            : Get.offAllNamed(UserRoutes.userDashboard);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          Get.showSnackbar(GetSnackBar(
            message: 'Please enter a valid email.',
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 255, 61, 22),
          ));
        } else if (e.code == 'weak-password') {
          Get.showSnackbar(GetSnackBar(
            message: 'The password provided is too weak.',
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 255, 61, 22),
          ));
        } else if (e.code == 'email-already-in-use') {
          Get.showSnackbar(GetSnackBar(
            message: 'The account already exists for that email.',
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 255, 61, 22),
          ));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (email == '') {
      Get.showSnackbar(GetSnackBar(
        message: 'Please enter your email.',
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 61, 22),
      ));
    } else if (password == '') {
      Get.showSnackbar(GetSnackBar(
        message: 'Please enter an password.',
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 61, 22),
      ));
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        isSwitched
            ? Get.offAllNamed(RecruiterRoutes.recruiterDashboard)
            : isAdmin
                ? Get.offAllNamed(AdminRoutes.adminDashboard)
                : Get.offAllNamed(UserRoutes.userDashboard);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.showSnackbar(GetSnackBar(
            message: "No user found for that email.",
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 255, 61, 22),
          ));
        } else if (e.code == 'wrong-password') {
          Get.showSnackbar(GetSnackBar(
            message: "Please check password you entered.",
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 255, 61, 22),
          ));
        }
      }
    }
  }

  Future<void> logout() async =>
      await _auth.signOut().then((_) => Get.offAll(() => LoginScreen()));

  Future<void> sendPasswordResetEmail(String email) async {
    if (email == '') {
      Get.showSnackbar(GetSnackBar(
        message: 'Please enter your email to send request.',
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 61, 22),
      ));
    } else {
      await _auth
        ..sendPasswordResetEmail(email: email);
      Get.offAll(() => LoginScreen());
      Get.showSnackbar(GetSnackBar(
        message: 'Request has been send. Please check your inbox',
        duration: Duration(seconds: 2),
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.done,
          color: Colors.green,
          size: 20,
        ),
      ));
    }
  }

  Future<void> phoneAuthentication(String phone) async {
    await _auth
      ..verifyPhoneNumber(
        phoneNumber: "+91" + phone,
        verificationCompleted: (credential) async {},
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The Provided Phone Number is not Valid');
          } else {
            Get.snackbar('Error', 'Something went wrong');
          }
        },
      );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      final phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: this.verificationId.value, smsCode: otp);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        Get.showSnackbar(GetSnackBar(
          message: 'The provided OTP is invalid.',
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromARGB(255, 255, 61, 22),
        ));
      }
      return false;
    }
  }

  Future<void> sendEmailVerification() async {
    await _auth
      ..currentUser!.sendEmailVerification();
  }

  // for admin

  Future<void> createUserforAdmin(
      String name, String email, String password) async {
    if (name == "") {
      Get.showSnackbar(GetSnackBar(
        message: 'Please enter a name.',
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 61, 22),
      ));
    } else if (email == "") {
      Get.showSnackbar(GetSnackBar(
        message: 'Please enter an email.',
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 61, 22),
      ));
    } else if (password == "") {
      Get.showSnackbar(GetSnackBar(
        message: 'Please enter a password.',
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 255, 61, 22),
      ));
    } else {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Get.showSnackbar(GetSnackBar(
          message: 'User created Successfully.',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          Get.showSnackbar(GetSnackBar(
            message: 'Please enter a valid email.',
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 255, 61, 22),
          ));
        } else if (e.code == 'weak-password') {
          Get.showSnackbar(GetSnackBar(
            message: 'The password provided is too weak.',
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 255, 61, 22),
          ));
        } else if (e.code == 'email-already-in-use') {
          Get.showSnackbar(GetSnackBar(
            message: 'The account already exists for that email.',
            duration: Duration(seconds: 2),
            backgroundColor: Color.fromARGB(255, 255, 61, 22),
          ));
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
