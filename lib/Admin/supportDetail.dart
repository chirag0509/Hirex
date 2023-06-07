import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/main.dart';

class SupportDetail extends StatefulWidget {
  final String name;
  final String email;
  final String subject;
  final String message;
  final String id;
  SupportDetail(
      {Key? key,
      required this.email,
      required this.id,
      required this.name,
      required this.subject,
      required this.message})
      : super(key: key);

  @override
  State<SupportDetail> createState() => _SupportDetailState();
}

class _SupportDetailState extends State<SupportDetail> {
  final messageController = TextEditingController();

  Future<void> sendEmail(
      String subject, String body, String recipientEmail) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recipientEmail],
    );

    try {
      await FlutterEmailSender.send(email);
      await FirebaseFirestore.instance
          .collection("Support")
          .doc(widget.id)
          .delete();
      print('Email sent successfully');
    } catch (error) {
      print('Error sending email: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: darkMode ? whiteColor : blackColor),
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: w * 0.05,
                        ),
                        Text(
                          "● Name : " + widget.name.capitalize.toString(),
                          style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
                        ),
                        SizedBox(
                          height: w * 0.025,
                        ),
                        Text(
                          "● Email : " + widget.email.capitalize.toString(),
                          style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
                        ),
                        SizedBox(
                          height: w * 0.025,
                        ),
                        Text(
                          "● Subject : " + widget.subject.capitalize.toString(),
                          style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
                        ),
                        SizedBox(
                          height: w * 0.025,
                        ),
                        Text(
                          "● Feedback : " +
                              widget.message.capitalize.toString(),
                          style: TextStyle(
                              fontSize: w * 0.045,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
                        ),
                        SizedBox(
                          height: w * 0.05,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: orangeColor, width: 3))),
                  ),
                  SizedBox(
                    height: w * 0.05,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: messageController,
                          style: TextStyle(
                              color: darkMode ? whiteColor : blackColor),
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
                            fillColor:
                                darkMode ? inputDarkColor : inputLightColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: w * 0.05),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          maxLines: 15,
                        ),
                        SizedBox(
                          height: w * 0.05,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                sendEmail(
                                        "Reply",
                                        messageController.text.trim(),
                                        widget.email)
                                    .then((_) => Navigator.pop(context));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      darkMode ? orangeColor : blackColor,
                                  padding:
                                      EdgeInsets.symmetric(vertical: w * 0.035),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                "Send Message",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: darkMode ? blackColor : whiteColor),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
