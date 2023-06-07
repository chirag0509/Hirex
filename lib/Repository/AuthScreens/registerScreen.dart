import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/OffPages/helpScreen.dart';
import 'package:mca_app_1/OffPages/welcomeScreen.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/recruiterRepository.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/Repository/AuthScreens/loginScreen.dart';
import 'package:mca_app_1/Repository/Database/userRepository.dart';
import 'package:mca_app_1/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../Authentication/authRepository.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Get.put(AuthRepository());
  final userRepo = Get.put(UserRepository());
  final recruiterRepo = Get.put(RecruiterRepository());

  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  _saveBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isSwitched", isSwitched);
  }

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsets.symmetric(vertical: w * 0.08, horizontal: w * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: orangeColor,
                        size: w * 0.075,
                      ),
                    ),
                    SizedBox(
                      height: w * 0.04,
                    ),
                    Text(
                      "Register",
                      style: TextStyle(
                          color: blackColor,
                          fontSize: w * 0.075,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: w * 0.12,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.9,
                            child: CupertinoSwitch(
                                value: isSwitched,
                                activeColor: orangeColor,
                                onChanged: (bool value) {
                                  setState(() {
                                    isSwitched = value;
                                    _saveBool();
                                  });
                                }),
                          ),
                          SizedBox(
                            width: w * 0.01,
                          ),
                          Text(
                            "Recruiter",
                            style: TextStyle(fontSize: w * 0.05),
                          )
                        ],
                      ),
                      SizedBox(
                        height: w * 0.04,
                      ),
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "Name",
                          prefixIcon: Icon(Icons.account_box_rounded),
                          hintStyle: TextStyle(fontSize: w * 0.045),
                          fillColor: inputLightColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(w * 1)),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: w * 0.045),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: orangeColor, width: 1),
                              borderRadius: BorderRadius.circular(w * 1)),
                        ),
                      ),
                      SizedBox(
                        height: w * 0.04,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          hintStyle: TextStyle(fontSize: w * 0.045),
                          fillColor: inputLightColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(w * 1)),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: w * 0.045),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: orangeColor, width: 1),
                              borderRadius: BorderRadius.circular(w * 1)),
                        ),
                      ),
                      SizedBox(
                        height: w * 0.04,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          hintStyle: TextStyle(fontSize: w * 0.045),
                          fillColor: inputLightColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(w * 1)),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: w * 0.045),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: orangeColor, width: 1),
                              borderRadius: BorderRadius.circular(w * 1)),
                        ),
                      ),
                      SizedBox(
                        height: w * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.to(() => HelpScreen());
                            },
                            child: Text("Need help?",
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: w * 0.045,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: w * 0.01,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.createUserWithEmailAndPassword(
                                    name.text.trim(),
                                    email.text.trim(),
                                    password.text.trim());
                                if (name.text.trim() != "" ||
                                    email.text.trim() != "" ||
                                    password.text.trim() != "") {
                                  if (isSwitched) {
                                    final recruiter = RecruiterModel(
                                      id: Random().toString(),
                                      name: name.text.trim(),
                                      email: email.text.trim(),
                                      password: password.text.trim(),
                                      phone: "",
                                      vacancy: "",
                                      address: "",
                                      requirements: "",
                                      verified: "",
                                      image:
                                          'https://firebasestorage.googleapis.com/v0/b/miniproject1sem1.appspot.com/o/avatar.png?alt=media&token=ee25b340-fa48-4721-b480-def52626e826',
                                      company: "",
                                    );
                                    recruiterRepo.createRecruiter(recruiter);
                                  } else {
                                    final user = UserModel(
                                        id: Random().toString(),
                                        name: name.text.trim(),
                                        email: email.text.trim(),
                                        address: "",
                                        qualification: "",
                                        experience: "",
                                        phone: "",
                                        expertise: "",
                                        block: "",
                                        verified: "",
                                        documents: [],
                                        image:
                                            'https://firebasestorage.googleapis.com/v0/b/miniproject1sem1.appspot.com/o/avatar.png?alt=media&token=ee25b340-fa48-4721-b480-def52626e826',
                                        password: password.text.trim());
                                    userRepo.createUser(user);
                                  }
                                }
                              }
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: whiteColor, fontSize: w * 0.065),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding:
                                  EdgeInsets.symmetric(vertical: w * 0.035),
                              backgroundColor: blackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(w * 1)),
                              elevation: 5,
                            )),
                      ),
                      SizedBox(
                        height: w * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.w500)),
                          TextButton(
                            onPressed: () {
                              Get.to(() => LoginScreen());
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: orangeColor,
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
