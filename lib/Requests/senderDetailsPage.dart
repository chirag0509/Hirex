import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Chats/chatDetails.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/requestModel.dart';
import 'package:mca_app_1/Repository/Database/requestRepository.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/Repository/Database/userRepository.dart';
import 'package:mca_app_1/main.dart';
import 'package:mca_app_1/pdfViewerPage.dart';

class SenderDetailsPage extends StatefulWidget {
  final String sender;
  final String receiver;
  final String id;
  final String status;
  SenderDetailsPage(
      {Key? key,
      required this.sender,
      required this.id,
      required this.status,
      required this.receiver})
      : super(key: key);

  @override
  State<SenderDetailsPage> createState() => _SenderDetailsPageState();
}

class _SenderDetailsPageState extends State<SenderDetailsPage> {
  final _db = FirebaseFirestore.instance;

  final requestController = Get.put(RequestRepository());
  final userController = Get.put(UserRepository());

  Stream<RecruiterModel> getRecruiter() {
    return _db
        .collection("Recruiters")
        .where("email",
            isEqualTo: widget.receiver ==
                    AuthRepository.instance.firebaseUser.value!.email
                ? widget.sender
                : widget.receiver)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => RecruiterModel.fromSnapshot(e)).single);
  }

  Stream<UserModel> getUser() {
    return _db
        .collection("Users")
        .where("email",
            isEqualTo: widget.receiver ==
                    AuthRepository.instance.firebaseUser.value!.email
                ? widget.sender
                : widget.receiver)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.height;
    final mqw = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: darkMode ? whiteColor : blackColor),
          elevation: 0,
          backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
        ),
        body: SingleChildScrollView(
            child: StreamBuilder(
                stream: getRecruiter(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                snapshot.data!.image),
                            radius: 60,
                          ),
                        ),
                        SizedBox(
                          height: mq * 0.02,
                        ),
                        Text(
                          snapshot.data!.name.toUpperCase(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
                        ),
                        SizedBox(
                          height: mq * 0.04,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: mqw * 0.04),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2.5, color: orangeColor))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: mqw * 0.04,
                                    color: darkMode ? orangeColor : blackColor,
                                  ),
                                  SizedBox(
                                    width: mqw * 0.025,
                                  ),
                                  Text(
                                    !showSent
                                        ? snapshot.data!.email
                                        : "Email : ".toUpperCase() +
                                            "*" * snapshot.data!.email.length,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq * 0.025,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: mqw * 0.04,
                                    color: darkMode ? orangeColor : blackColor,
                                  ),
                                  SizedBox(
                                    width: mqw * 0.025,
                                  ),
                                  Text(
                                    "phone : ".toUpperCase() +
                                        "*" * snapshot.data!.phone.length,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq * 0.025,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: mqw * 0.04,
                                    color: darkMode ? orangeColor : blackColor,
                                  ),
                                  SizedBox(
                                    width: mqw * 0.025,
                                  ),
                                  Text(
                                    "company : ".toUpperCase() +
                                        snapshot.data!.company.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq * 0.025,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: mqw * 0.04,
                                    color: darkMode ? orangeColor : blackColor,
                                  ),
                                  SizedBox(
                                    width: mqw * 0.025,
                                  ),
                                  Text(
                                    "requirements : ".toUpperCase() +
                                        snapshot.data!.requirements
                                            .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq * 0.025,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: mqw * 0.04,
                                    color: darkMode ? orangeColor : blackColor,
                                  ),
                                  SizedBox(
                                    width: mqw * 0.025,
                                  ),
                                  Text(
                                    "vacancy : ".toUpperCase() +
                                        snapshot.data!.vacancy.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq * 0.025,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: mqw * 0.04,
                                        color:
                                            darkMode ? orangeColor : blackColor,
                                      ),
                                      SizedBox(
                                        width: mqw * 0.025,
                                      ),
                                      Text(
                                        "company address : ".toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: darkMode
                                                ? whiteColor
                                                : blackColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: mq * 0.01,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: mqw * 0.065),
                                    child: Text(
                                      snapshot.data!.address.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: darkMode
                                              ? whiteColor
                                              : blackColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq * 0.025,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mq * 0.025,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: mqw * 0.04),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.label_important,
                                    size: mqw * 0.055,
                                    color: darkMode ? orangeColor : blackColor,
                                  ),
                                  SizedBox(
                                    width: mqw * 0.025,
                                  ),
                                  Text(
                                    "description : ".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq * 0.015,
                              ),
                              Text(
                                "Hi! I am ${snapshot.data!.name.capitalize}. I am a recruiter working at ${snapshot.data!.company.capitalize}. We need an employee having knowledge in ${snapshot.data!.requirements.capitalize}. We have ${snapshot.data!.vacancy} vacant seats. If you have any doubt then you can drop a message on chat box.",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: darkMode ? whiteColor : blackColor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mq * 0.03,
                        ),
                        StreamBuilder(
                            stream: userController.getUserDetails(),
                            builder: (context, userSnapshot) {
                              if (userSnapshot.hasData) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.status == "accepted"
                                        ? Container(
                                            width: mqw * 0.75,
                                            child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .green,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                mq * 0.015),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                child: Text(
                                                  "Accepted",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: whiteColor),
                                                )),
                                          )
                                        : (widget.status == "pending" &&
                                                widget.receiver ==
                                                    AuthRepository
                                                        .instance
                                                        .firebaseUser
                                                        .value!
                                                        .email)
                                            ? Column(
                                                children: [
                                                  Container(
                                                    width: mqw * 0.75,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          final request = RequestModel(
                                                              id: widget.id,
                                                              sender:
                                                                  widget.sender,
                                                              receiver:
                                                                  AuthRepository
                                                                      .instance
                                                                      .firebaseUser
                                                                      .value!
                                                                      .email
                                                                      .toString(),
                                                              status:
                                                                  "accepted",
                                                              time: Timestamp
                                                                  .now());
                                                          await requestController
                                                              .updateRequestRecord(
                                                                  widget.id,
                                                                  request);
                                                          final user = UserModel(
                                                              id: userSnapshot
                                                                  .data!.id,
                                                              name: userSnapshot
                                                                  .data!.name,
                                                              email: userSnapshot
                                                                  .data!.email,
                                                              password: userSnapshot
                                                                  .data!
                                                                  .password,
                                                              verified: userSnapshot
                                                                  .data!
                                                                  .verified,
                                                              phone: userSnapshot
                                                                  .data!.phone,
                                                              address: userSnapshot
                                                                  .data!
                                                                  .address,
                                                              qualification:
                                                                  userSnapshot
                                                                      .data!
                                                                      .qualification,
                                                              experience: userSnapshot
                                                                  .data!
                                                                  .experience,
                                                              image: userSnapshot
                                                                  .data!.image,
                                                              expertise: userSnapshot
                                                                  .data!
                                                                  .expertise,
                                                              documents: userSnapshot
                                                                  .data!
                                                                  .documents,
                                                              block: "blocked");
                                                          await userController
                                                              .updateUserRecord(
                                                                  user);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: mq *
                                                                        0.015),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15))),
                                                        child: Text(
                                                          "Accept",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  whiteColor),
                                                        )),
                                                  ),
                                                  SizedBox(height: mq * 0.01),
                                                  Container(
                                                    width: mqw * 0.75,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          final request = RequestModel(
                                                              id: widget.id,
                                                              sender:
                                                                  widget.sender,
                                                              receiver:
                                                                  AuthRepository
                                                                      .instance
                                                                      .firebaseUser
                                                                      .value!
                                                                      .email
                                                                      .toString(),
                                                              status:
                                                                  "rejected",
                                                              time: Timestamp
                                                                  .fromDate(Timestamp
                                                                          .now()
                                                                      .toDate()
                                                                      .add(Duration(
                                                                          days:
                                                                              90))));
                                                          await requestController
                                                              .updateRequestRecord(
                                                                  widget.id,
                                                                  request);
                                                          setState(() {});
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: mq *
                                                                        0.015),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15))),
                                                        child: Text(
                                                          "Reject",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  whiteColor),
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : Container(
                                                width: mqw * 0.75,
                                                child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            darkMode
                                                                ? orangeColor
                                                                : blackColor,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    mq * 0.015),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                    child: Text(
                                                      "Pending",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: darkMode
                                                              ? blackColor
                                                              : whiteColor),
                                                    )),
                                              ),
                                    Container(
                                      width: mqw * 0.15,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(() => ChatDetails(
                                              sender: snapshot.data!.email,
                                              image: snapshot.data!.image,
                                              name: snapshot.data!.name));
                                        },
                                        child: Icon(
                                          Icons.chat,
                                          size: mqw * 0.125,
                                          color: darkMode
                                              ? whiteColor
                                              : orangeColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    );
                  } else {
                    return StreamBuilder(
                        stream: getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                        snapshot.data!.image),
                                    radius: 60,
                                  ),
                                ),
                                SizedBox(
                                  height: mq * 0.02,
                                ),
                                Text(
                                  snapshot.data!.name.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          darkMode ? whiteColor : blackColor),
                                ),
                                SizedBox(
                                  height: mq * 0.04,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mqw * 0.04),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 2.5, color: orangeColor))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: mqw * 0.04,
                                            color: darkMode
                                                ? orangeColor
                                                : blackColor,
                                          ),
                                          SizedBox(
                                            width: mqw * 0.025,
                                          ),
                                          Text(
                                            !showSent
                                                ? snapshot.data!.email
                                                : "Email : ".toUpperCase() +
                                                    "*" *
                                                        snapshot
                                                            .data!.email.length,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: darkMode
                                                    ? whiteColor
                                                    : blackColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mq * 0.025,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: mqw * 0.04,
                                            color: darkMode
                                                ? orangeColor
                                                : blackColor,
                                          ),
                                          SizedBox(
                                            width: mqw * 0.025,
                                          ),
                                          Text(
                                            "phone : ".toUpperCase() +
                                                "*" *
                                                    snapshot.data!.phone.length,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: darkMode
                                                    ? whiteColor
                                                    : blackColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mq * 0.025,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: mqw * 0.04,
                                            color: darkMode
                                                ? orangeColor
                                                : blackColor,
                                          ),
                                          SizedBox(
                                            width: mqw * 0.025,
                                          ),
                                          Text(
                                            "qualification : ".toUpperCase() +
                                                snapshot.data!.qualification
                                                    .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: darkMode
                                                    ? whiteColor
                                                    : blackColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mq * 0.025,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: mqw * 0.04,
                                            color: darkMode
                                                ? orangeColor
                                                : blackColor,
                                          ),
                                          SizedBox(
                                            width: mqw * 0.025,
                                          ),
                                          Text(
                                            "expertise : ".toUpperCase() +
                                                snapshot.data!.expertise
                                                    .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: darkMode
                                                    ? whiteColor
                                                    : blackColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mq * 0.025,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: mqw * 0.04,
                                            color: darkMode
                                                ? orangeColor
                                                : blackColor,
                                          ),
                                          SizedBox(
                                            width: mqw * 0.025,
                                          ),
                                          Text(
                                            "experience : ".toUpperCase() +
                                                snapshot.data!.experience
                                                    .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: darkMode
                                                    ? whiteColor
                                                    : blackColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mq * 0.025,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mq * 0.025,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mqw * 0.04),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.label_important,
                                            size: mqw * 0.055,
                                            color: darkMode
                                                ? orangeColor
                                                : blackColor,
                                          ),
                                          SizedBox(
                                            width: mqw * 0.025,
                                          ),
                                          Text(
                                            "description : ".toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: darkMode
                                                    ? whiteColor
                                                    : blackColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mq * 0.015,
                                      ),
                                      Text(
                                        "Hi! I am ${snapshot.data!.name.capitalize}. I am a ${snapshot.data!.expertise.capitalize} developer. I have ${snapshot.data!.experience.capitalize} of experience. I have done ${snapshot.data!.qualification.capitalize}. If you have any doubt then you can drop a message on chat box.",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: darkMode
                                                ? whiteColor
                                                : blackColor),
                                      ),
                                      SizedBox(
                                        height: mq * 0.015,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mq * 0.015,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mqw * 0.04),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.label_important,
                                            size: mqw * 0.055,
                                            color: darkMode
                                                ? orangeColor
                                                : blackColor,
                                          ),
                                          SizedBox(
                                            width: mqw * 0.025,
                                          ),
                                          Text(
                                            "documents : ".toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: darkMode
                                                    ? whiteColor
                                                    : blackColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: mq * 0.015,
                                      ),
                                      GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                childAspectRatio: 0.75),
                                        itemCount:
                                            snapshot.data!.documents!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  File file = await PDFApi
                                                      .loadNetwork(snapshot
                                                              .data!
                                                              .documents![index]
                                                          ["url"]);
                                                  Get.to(() => PDFViewerPage(
                                                      file: file,
                                                      name: snapshot.data!
                                                              .documents![index]
                                                          ["name"]));
                                                },
                                                child: Container(
                                                  child: Image.asset(
                                                    "assets/images/PDF_image.png",
                                                    width: mqw * 0.25,
                                                  ),
                                                ),
                                              ),
                                              Text(snapshot.data!
                                                  .documents![index]["name"]),
                                            ],
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: mq * 0.015,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mq * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.status == "accepted"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: mqw * 0.75,
                                                child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.green,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    mq * 0.015),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                    child: Text(
                                                      "Accepted",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: whiteColor),
                                                    )),
                                              ),
                                              SizedBox(height: mq * 0.01),
                                              snapshot.data!.block == "blocked"
                                                  ? Container(
                                                      width: mqw * 0.75,
                                                      child: ElevatedButton(
                                                          onPressed: () async {
                                                            final user = UserModel(
                                                                id: snapshot
                                                                    .data!.id,
                                                                name: snapshot
                                                                    .data!.name,
                                                                email: snapshot
                                                                    .data!
                                                                    .email,
                                                                password: snapshot
                                                                    .data!
                                                                    .password,
                                                                verified: snapshot
                                                                    .data!
                                                                    .verified,
                                                                phone: snapshot
                                                                    .data!
                                                                    .phone,
                                                                address: snapshot
                                                                    .data!
                                                                    .address,
                                                                qualification:
                                                                    snapshot
                                                                        .data!
                                                                        .qualification,
                                                                experience: snapshot
                                                                    .data!
                                                                    .experience,
                                                                image: snapshot
                                                                    .data!
                                                                    .image,
                                                                expertise: snapshot
                                                                    .data!
                                                                    .expertise,
                                                                documents: snapshot
                                                                    .data!
                                                                    .documents,
                                                                block: "");
                                                            await userController
                                                                .updateUserRecord(
                                                                    user);
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  darkMode
                                                                      ? orangeColor
                                                                      : blackColor,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical: mq *
                                                                          0.015),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15))),
                                                          child: Text(
                                                            "Unblock",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: darkMode
                                                                    ? blackColor
                                                                    : whiteColor),
                                                          )),
                                                    )
                                                  : Container(
                                                      width: mqw * 0.75,
                                                      child: ElevatedButton(
                                                          onPressed: () {},
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  darkMode
                                                                      ? orangeColor
                                                                      : blackColor,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical: mq *
                                                                          0.015),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15))),
                                                          child: Text(
                                                            "Unblocked",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: darkMode
                                                                  ? blackColor
                                                                  : whiteColor,
                                                            ),
                                                          )),
                                                    ),
                                            ],
                                          )
                                        : (widget.status == "pending" &&
                                                widget.receiver ==
                                                    AuthRepository
                                                        .instance
                                                        .firebaseUser
                                                        .value!
                                                        .email)
                                            ? Column(
                                                children: [
                                                  Container(
                                                    width: mqw * 0.75,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          final request = RequestModel(
                                                              id: widget.id,
                                                              sender:
                                                                  widget.sender,
                                                              receiver:
                                                                  AuthRepository
                                                                      .instance
                                                                      .firebaseUser
                                                                      .value!
                                                                      .email
                                                                      .toString(),
                                                              status:
                                                                  "accepted",
                                                              time: Timestamp
                                                                  .now());
                                                          await requestController
                                                              .updateRequestRecord(
                                                                  widget.id,
                                                                  request);
                                                          final user = UserModel(
                                                              id: snapshot
                                                                  .data!.id,
                                                              name: snapshot
                                                                  .data!.name,
                                                              email: snapshot
                                                                  .data!.email,
                                                              password: snapshot
                                                                  .data!
                                                                  .password,
                                                              verified: snapshot
                                                                  .data!
                                                                  .verified,
                                                              phone: snapshot
                                                                  .data!.phone,
                                                              address: snapshot
                                                                  .data!
                                                                  .address,
                                                              qualification:
                                                                  snapshot.data!
                                                                      .qualification,
                                                              experience: snapshot
                                                                  .data!
                                                                  .experience,
                                                              image: snapshot
                                                                  .data!.image,
                                                              expertise: snapshot
                                                                  .data!
                                                                  .expertise,
                                                              documents: snapshot
                                                                  .data!
                                                                  .documents,
                                                              block: "blocked");
                                                          await userController
                                                              .updateUserRecord(
                                                                  user);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: mq *
                                                                        0.015),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15))),
                                                        child: Text(
                                                          "Accept",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  whiteColor),
                                                        )),
                                                  ),
                                                  SizedBox(height: mq * 0.01),
                                                  Container(
                                                    width: mqw * 0.75,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          final request = RequestModel(
                                                              id: widget.id,
                                                              sender:
                                                                  widget.sender,
                                                              receiver:
                                                                  AuthRepository
                                                                      .instance
                                                                      .firebaseUser
                                                                      .value!
                                                                      .email
                                                                      .toString(),
                                                              status:
                                                                  "rejected",
                                                              time: Timestamp
                                                                  .fromDate(Timestamp
                                                                          .now()
                                                                      .toDate()
                                                                      .add(Duration(
                                                                          days:
                                                                              90))));
                                                          await requestController
                                                              .updateRequestRecord(
                                                                  widget.id,
                                                                  request);
                                                          setState(() {});
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: mq *
                                                                        0.015),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15))),
                                                        child: Text(
                                                          "Reject",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  whiteColor),
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : Container(
                                                width: mqw * 0.75,
                                                child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            darkMode
                                                                ? orangeColor
                                                                : blackColor,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    mq * 0.015),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                    child: Text(
                                                      "Pending",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: darkMode
                                                              ? blackColor
                                                              : whiteColor),
                                                    )),
                                              ),
                                    Container(
                                      width: mqw * 0.15,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.to(() => ChatDetails(
                                              sender: snapshot.data!.email,
                                              image: snapshot.data!.image,
                                              name: snapshot.data!.name));
                                        },
                                        child: Icon(
                                          Icons.chat,
                                          size: mqw * 0.125,
                                          color: darkMode
                                              ? whiteColor
                                              : orangeColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: mqw * 0.05,
                                )
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  }
                })),
      ),
    );
  }
}
