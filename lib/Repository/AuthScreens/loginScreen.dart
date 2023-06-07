import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/OffPages/helpScreen.dart';
import 'package:mca_app_1/OffPages/welcomeScreen.dart';
import 'package:mca_app_1/Repository/AuthScreens/forgetScreen.dart';
import 'package:mca_app_1/Repository/AuthScreens/registerScreen.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(AuthRepository());
  final authController = Get.put(AuthRepository());

  bool passwordVisible = false;

  final email = TextEditingController();
  final password = TextEditingController();

  _saveBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isSwitched", isSwitched);
    await prefs.setBool("isAdmin", isAdmin);
  }

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
                      "Sign In",
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
                          ),
                          SizedBox(
                            width: w * 0.01,
                          ),
                          Transform.scale(
                            scale: 0.9,
                            child: CupertinoSwitch(
                                value: isAdmin,
                                activeColor: orangeColor,
                                onChanged: (bool value) {
                                  setState(() {
                                    isAdmin = value;
                                    _saveBool();
                                  });
                                }),
                          ),
                          SizedBox(
                            width: w * 0.01,
                          ),
                          Text(
                            "Admin",
                            style: TextStyle(fontSize: w * 0.05),
                          )
                        ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          TextButton(
                            onPressed: () {
                              Get.to(() => ForgetScreen());
                            },
                            child: Text("Forget Password?",
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: w * 0.045,
                                    fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: w * 0.01,
                      ),
                      Container(
                          width: double.infinity,
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    AuthRepository.instance
                                        .signInWithEmailAndPassword(
                                            email.text.trim(),
                                            password.text.trim());
                                  }
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: whiteColor, fontSize: w * 0.065),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.symmetric(vertical: w * 0.035),
                                  backgroundColor: blackColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(w * 1)),
                                  elevation: 5,
                                )),
                          )),
                      SizedBox(
                        height: w * 0.04,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(
                            fontSize: w * 0.045, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.w500)),
                          TextButton(
                            onPressed: () {
                              Get.to(() => RegisterScreen());
                            },
                            child: Text(
                              "Register",
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
