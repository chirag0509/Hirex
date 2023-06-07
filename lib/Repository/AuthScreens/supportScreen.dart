import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/Database/supportModel.dart';
import 'package:mca_app_1/Repository/Database/supportRepository.dart';
import 'package:mca_app_1/main.dart';
import 'package:mca_app_1/routes.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final subject = TextEditingController();
  final message = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(SupportRepository());
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.height;
    final mqw = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: mq * 0.03, horizontal: mqw * 0.07),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: mqw * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: orangeColor,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              "SUPPORT",
                              style: TextStyle(
                                  color: orangeColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mq * 0.05,
                    ),
                    TextFormField(
                      controller: name,
                      style:
                          TextStyle(color: darkMode ? whiteColor : blackColor),
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(
                          Icons.account_box_rounded,
                          color: darkMode ? whiteColor : blackColor,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: darkMode ? whiteColor : blackColor),
                        fillColor: darkMode ? inputDarkColor : inputLightColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: mq * 0.025),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(
                      height: mq * 0.02,
                    ),
                    TextFormField(
                      controller: email,
                      style:
                          TextStyle(color: darkMode ? whiteColor : blackColor),
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: darkMode ? whiteColor : blackColor,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: darkMode ? whiteColor : blackColor),
                        fillColor: darkMode ? inputDarkColor : inputLightColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: mq * 0.025),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(
                      height: mq * 0.02,
                    ),
                    TextFormField(
                      controller: subject,
                      style:
                          TextStyle(color: darkMode ? whiteColor : blackColor),
                      decoration: InputDecoration(
                        labelText: "Subject",
                        prefixIcon: Icon(
                          Icons.subject_rounded,
                          color: darkMode ? whiteColor : blackColor,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: darkMode ? whiteColor : blackColor),
                        fillColor: darkMode ? inputDarkColor : inputLightColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: mq * 0.025),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    SizedBox(
                      height: mq * 0.02,
                    ),
                    TextFormField(
                      controller: message,
                      style:
                          TextStyle(color: darkMode ? whiteColor : blackColor),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: "Message",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 270),
                          child: Icon(Icons.message_rounded,
                              color: darkMode ? whiteColor : blackColor),
                        ),
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: darkMode ? whiteColor : blackColor),
                        fillColor: darkMode ? inputDarkColor : inputLightColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: mq * 0.025),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      maxLines: 15,
                    ),
                    SizedBox(
                      height: mq * 0.02,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final support = SupportModel(
                                  id: Random().toString(),
                                  name: name.text.trim(),
                                  email: email.text.trim(),
                                  subject: subject.text.trim(),
                                  message: message.text.trim());
                              controller.createApplication(support);
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: darkMode ? blackColor : whiteColor,
                                fontSize: 30),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: mq * 0.012),
                            backgroundColor:
                                darkMode ? orangeColor : blackColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 5,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
