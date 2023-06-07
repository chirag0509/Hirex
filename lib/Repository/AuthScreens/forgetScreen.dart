import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/main.dart';
import 'package:mca_app_1/routes.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final controller = Get.put(AuthRepository());
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();

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
                      "Forget Password",
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
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                          labelStyle: TextStyle(fontSize: w * 0.045),
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
                      Container(
                          width: double.infinity,
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    AuthRepository.instance
                                        .sendPasswordResetEmail(
                                            email.text.trim());
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: w * 0.065),
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
