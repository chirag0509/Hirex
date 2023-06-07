import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Chats/chatDetails.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/recruiterRepository.dart';
import 'package:mca_app_1/Repository/Database/requestModel.dart';
import 'package:mca_app_1/Repository/Database/requestRepository.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/main.dart';
import 'package:mca_app_1/pdfViewerPage.dart';

class UserDetail extends StatefulWidget {
  final UserModel user;
  UserDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final controller = Get.put(RecruiterRepository());
  final requestController = Get.put(RequestRepository());

  Stream<RequestModel> getRequestDetails() {
    return FirebaseFirestore.instance.collection("Requests").snapshots().map(
        (snapshot) => snapshot.docs
            .map((e) => RequestModel.fromSnapshot(e))
            .singleWhere((request) =>
                request.sender ==
                    AuthRepository.instance.firebaseUser.value!.email &&
                request.receiver == widget.user.email));
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
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(widget.user.image),
                  radius: 60,
                ),
              ),
              SizedBox(
                height: mq * 0.02,
              ),
              Text(
                widget.user.name.toUpperCase(),
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
                        bottom: BorderSide(width: 2.5, color: orangeColor))),
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
                          "Email : ".toUpperCase() +
                              "*" * widget.user.email.length,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
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
                              "*" * widget.user.phone.length,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
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
                          "qualification : ".toUpperCase() +
                              widget.user.qualification.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
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
                          "expertise : ".toUpperCase() +
                              widget.user.expertise.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
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
                          "experience : ".toUpperCase() +
                              widget.user.experience.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
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
                              color: darkMode ? whiteColor : blackColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mq * 0.015,
                    ),
                    Text(
                      "Hi! I am ${widget.user.name.capitalize}. I am a ${widget.user.expertise.capitalize} developer. I have ${widget.user.experience.capitalize} of experience. I have done ${widget.user.qualification.capitalize}. If you have any doubt then you can drop a message on chat box.",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: darkMode ? whiteColor : blackColor),
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
                          "documents : ".toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: darkMode ? whiteColor : blackColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mq * 0.015,
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.9),
                      itemCount: widget.user.documents!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                File file = await PDFApi.loadNetwork(
                                    widget.user.documents![index]["url"]);
                                Get.to(() => PDFViewerPage(
                                    file: file,
                                    name: widget.user.documents![index]
                                        ["name"]));
                              },
                              child: Image.asset(
                                "assets/images/PDF_image.png",
                                width: mqw * 0.25,
                              ),
                            ),
                            Text(
                              widget.user.documents![index]["name"]
                                  .toString()
                                  .capitalize
                                  .toString(),
                              style: TextStyle(
                                  fontSize: mqw * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: darkMode ? whiteColor : blackColor),
                            ),
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
                children: [
                  StreamBuilder(
                      stream: controller.getRecruiterDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return (snapshot.data!.requirements != "" &&
                                  snapshot.data!.phone != "" &&
                                  snapshot.data!.address != "" &&
                                  snapshot.data!.company != "" &&
                                  snapshot.data!.vacancy != "")
                              ? StreamBuilder(
                                  stream: getRequestDetails(),
                                  builder: (context, snapshot1) {
                                    if (snapshot1.hasData) {
                                      return snapshot1.data!.status == "pending"
                                          ? Container(
                                              width: mqw * 0.75,
                                              child: ElevatedButton(
                                                  onPressed: () {},
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: darkMode
                                                          ? orangeColor
                                                          : blackColor,
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
                                                    "Pending",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: darkMode
                                                            ? blackColor
                                                            : whiteColor),
                                                  )),
                                            )
                                          : snapshot1.data!.status ==
                                                      "rejected" &&
                                                  snapshot1.data!.time
                                                          .toDate()
                                                          .difference(
                                                              Timestamp.now()
                                                                  .toDate()) >
                                                      Duration(days: 0)
                                              ? Container(
                                                  width: mqw * 0.75,
                                                  child: ElevatedButton(
                                                      onPressed: () async {},
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
                                                        "Wait " +
                                                            snapshot1.data!.time
                                                                .toDate()
                                                                .difference(
                                                                    Timestamp
                                                                            .now()
                                                                        .toDate())
                                                                .inDays
                                                                .toString() +
                                                            " Days",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: darkMode
                                                                ? blackColor
                                                                : whiteColor),
                                                      )),
                                                )
                                              : snapshot1.data!.status ==
                                                          "rejected" &&
                                                      snapshot1.data!.time
                                                              .toDate()
                                                              .difference(
                                                                  Timestamp
                                                                          .now()
                                                                      .toDate()) <
                                                          Duration(days: 1)
                                                  ? Container(
                                                      width: mqw * 0.75,
                                                      child: ElevatedButton(
                                                          onPressed: () async {
                                                            final request = RequestModel(
                                                                id: Random()
                                                                    .toString(),
                                                                sender: snapshot
                                                                    .data!
                                                                    .email,
                                                                receiver: widget
                                                                    .user.email,
                                                                status:
                                                                    "pending",
                                                                time: Timestamp
                                                                    .now());
                                                            await requestController
                                                                .updateRequestRecord(
                                                                    snapshot1
                                                                        .data!
                                                                        .id,
                                                                    request);

                                                            setState(() {});
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
                                                            "Send Request",
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
                                                            "Accepted",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: darkMode
                                                                    ? blackColor
                                                                    : whiteColor),
                                                          )),
                                                    );
                                    } else {
                                      return Container(
                                        width: mqw * 0.75,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              final request = RequestModel(
                                                  id: Random().toString(),
                                                  sender: snapshot.data!.email,
                                                  receiver: widget.user.email,
                                                  status: "pending",
                                                  time: Timestamp.now());
                                              await requestController
                                                  .createRequest(request);

                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: darkMode
                                                    ? orangeColor
                                                    : blackColor,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: mq * 0.015),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            child: Text(
                                              "Send Request",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: darkMode
                                                      ? blackColor
                                                      : whiteColor),
                                            )),
                                      );
                                    }
                                  })
                              : Container(
                                  width: mqw * 0.75,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        userPageController.jumpToPage(3);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: darkMode
                                              ? Colors.white12
                                              : Colors.black38,
                                          padding: EdgeInsets.symmetric(
                                              vertical: mq * 0.015),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      child: Text(
                                        "First update Profile",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: darkMode
                                                ? orangeColor
                                                : whiteColor),
                                      )),
                                );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  Container(
                    width: mqw * 0.15,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatDetails(
                              sender: widget.user.email,
                              image: widget.user.image,
                              name: widget.user.name,
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.chat,
                        size: mqw * 0.125,
                        color: darkMode ? whiteColor : orangeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
