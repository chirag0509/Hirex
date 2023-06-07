import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/requestModel.dart';
import 'package:mca_app_1/Repository/Database/requestRepository.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/main.dart';
import 'package:mca_app_1/Requests/senderDetailsPage.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final controller = Get.put(RequestRepository());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: w * 0.29,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showSent = true;
                        showReceived = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: showSent
                          ? orangeColor
                          : darkMode
                              ? whiteColor
                              : blackColor,
                      padding: EdgeInsets.symmetric(vertical: w * 0.025),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 1)),
                    ),
                    child: Text(
                      "Sent",
                      style: TextStyle(
                          fontSize: w * 0.04,
                          color: showSent
                              ? blackColor
                              : darkMode
                                  ? blackColor
                                  : whiteColor),
                    ),
                  ),
                ),
                Container(
                  width: w * 0.29,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showReceived = true;
                        showSent = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: showReceived
                          ? orangeColor
                          : darkMode
                              ? whiteColor
                              : blackColor,
                      padding: EdgeInsets.symmetric(vertical: w * 0.025),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 1)),
                    ),
                    child: Text(
                      "Recieved",
                      style: TextStyle(
                          fontSize: w * 0.04,
                          color: showReceived
                              ? blackColor
                              : darkMode
                                  ? blackColor
                                  : whiteColor),
                    ),
                  ),
                ),
                Container(
                  width: w * 0.29,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showSent = false;
                        showReceived = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: !showReceived && !showSent
                          ? orangeColor
                          : darkMode
                              ? whiteColor
                              : blackColor,
                      padding: EdgeInsets.symmetric(vertical: w * 0.025),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 1)),
                    ),
                    child: Text(
                      "Accepted",
                      style: TextStyle(
                          fontSize: w * 0.04,
                          color: !showReceived && !showSent
                              ? blackColor
                              : darkMode
                                  ? blackColor
                                  : whiteColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: w * 0.05),
            showSent
                ? StreamBuilder<List<RequestModel>>(
                    stream: controller.getSentRequest(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.length != 0
                            ? ListView.builder(
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SenderDetailsPage(
                                                          sender: snapshot
                                                              .data![index]
                                                              .sender,
                                                          id: snapshot
                                                              .data![index].id,
                                                          status: snapshot
                                                              .data![index]
                                                              .status,
                                                          receiver: snapshot
                                                              .data![index]
                                                              .receiver)),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: darkMode
                                                ? inputDarkColor
                                                : whiteColor,
                                            padding: EdgeInsets.symmetric(
                                                vertical: w * 0.04,
                                                horizontal: w * 0.04),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            elevation: 2,
                                          ),
                                          child: StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection("Recruiters")
                                                  .snapshots()
                                                  .map((snapshot1) => snapshot1
                                                      .docs
                                                      .map((e) => RecruiterModel
                                                          .fromSnapshot(e))
                                                      .singleWhere((user) =>
                                                          user.email ==
                                                          snapshot.data![index]
                                                              .receiver)),
                                              builder: (context, snapshot1) {
                                                if (snapshot1.hasData) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundImage:
                                                                    CachedNetworkImageProvider(
                                                                        snapshot1
                                                                            .data!
                                                                            .image),
                                                                radius:
                                                                    w * 0.06,
                                                              ),
                                                              SizedBox(
                                                                width: w * 0.02,
                                                              ),
                                                              Text(
                                                                snapshot1
                                                                    .data!
                                                                    .name
                                                                    .capitalize
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: w *
                                                                        0.045,
                                                                    color: darkMode
                                                                        ? whiteColor
                                                                        : blackColor),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            snapshot1
                                                                .data!
                                                                .company
                                                                .capitalize
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    w * 0.035,
                                                                color: darkMode
                                                                    ? whiteColor
                                                                    : blackColor),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        DateFormat.yMMMd()
                                                            .add_jm()
                                                            .format(snapshot
                                                                .data![index]
                                                                .time
                                                                .toDate()),
                                                        style: TextStyle(
                                                            color: orangeColor),
                                                      )
                                                    ],
                                                  );
                                                } else {
                                                  return StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection("Users")
                                                          .snapshots()
                                                          .map((snapshot1) => snapshot1
                                                              .docs
                                                              .map((e) => UserModel
                                                                  .fromSnapshot(
                                                                      e))
                                                              .singleWhere((user) =>
                                                                  user.email ==
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .receiver)),
                                                      builder:
                                                          (context, snapshot1) {
                                                        if (snapshot1.hasData) {
                                                          return Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundImage: CachedNetworkImageProvider(snapshot1
                                                                            .data!
                                                                            .image),
                                                                        radius: w *
                                                                            0.06,
                                                                      ),
                                                                      SizedBox(
                                                                        width: w *
                                                                            0.02,
                                                                      ),
                                                                      Text(
                                                                        snapshot1
                                                                            .data!
                                                                            .name
                                                                            .capitalize
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: w *
                                                                                0.045,
                                                                            color: darkMode
                                                                                ? whiteColor
                                                                                : blackColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    snapshot1
                                                                        .data!
                                                                        .expertise
                                                                        .capitalize
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: w *
                                                                            0.035,
                                                                        color: darkMode
                                                                            ? whiteColor
                                                                            : blackColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                DateFormat
                                                                        .yMMMd()
                                                                    .add_jm()
                                                                    .format(snapshot
                                                                        .data![
                                                                            index]
                                                                        .time
                                                                        .toDate()),
                                                                style: TextStyle(
                                                                    color:
                                                                        orangeColor),
                                                              )
                                                            ],
                                                          );
                                                        } else {
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                      });
                                                }
                                              }),
                                        ),
                                      ),
                                      SizedBox(height: w * 0.015),
                                    ],
                                  );
                                })
                            : Column(
                                children: [
                                  SizedBox(height: w * 0.1),
                                  Text(
                                    "✌️",
                                    style: TextStyle(fontSize: w * 0.065),
                                  ),
                                  Text(
                                    "You have not send any request.",
                                    style: TextStyle(
                                        fontSize: w * 0.04,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              );
                      } else {
                        return Center(
                          child: CircularProgressIndicator()
                        );
                      }
                    },
                  )
                : showReceived
                    ? StreamBuilder<List<RequestModel>>(
                        stream: controller.getReceivedRequest(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.length != 0
                                ? ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SenderDetailsPage(
                                                              sender: snapshot
                                                                  .data![index]
                                                                  .sender,
                                                              id: snapshot
                                                                  .data![index]
                                                                  .id,
                                                              status: snapshot
                                                                  .data![index]
                                                                  .status,
                                                              receiver: snapshot
                                                                  .data![index]
                                                                  .receiver)),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: darkMode
                                                    ? inputDarkColor
                                                    : whiteColor,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: w * 0.04,
                                                    horizontal: w * 0.04),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                elevation: 2,
                                              ),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("Recruiters")
                                                      .snapshots()
                                                      .map((snapshot1) => snapshot1
                                                          .docs
                                                          .map((e) =>
                                                              RecruiterModel
                                                                  .fromSnapshot(
                                                                      e))
                                                          .singleWhere((user) =>
                                                              user.email ==
                                                              snapshot
                                                                  .data![index]
                                                                  .sender)),
                                                  builder:
                                                      (context, snapshot1) {
                                                    if (snapshot1.hasData) {
                                                      return Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage:
                                                                        CachedNetworkImageProvider(snapshot1
                                                                            .data!
                                                                            .image),
                                                                    radius: w *
                                                                        0.06,
                                                                  ),
                                                                  SizedBox(
                                                                    width: w *
                                                                        0.02,
                                                                  ),
                                                                  Text(
                                                                    snapshot1
                                                                        .data!
                                                                        .name
                                                                        .capitalize
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: w *
                                                                            0.045,
                                                                        color: darkMode
                                                                            ? whiteColor
                                                                            : blackColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                snapshot1
                                                                    .data!
                                                                    .company
                                                                    .capitalize
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: w *
                                                                        0.035,
                                                                    color: darkMode
                                                                        ? whiteColor
                                                                        : blackColor),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            DateFormat.yMMMd()
                                                                .add_jm()
                                                                .format(snapshot
                                                                    .data![
                                                                        index]
                                                                    .time
                                                                    .toDate()),
                                                            style: TextStyle(
                                                                color:
                                                                    orangeColor),
                                                          )
                                                        ],
                                                      );
                                                    } else {
                                                      return StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Users")
                                                              .snapshots()
                                                              .map((snapshot1) => snapshot1
                                                                  .docs
                                                                  .map((e) =>
                                                                      UserModel.fromSnapshot(
                                                                          e))
                                                                  .singleWhere((user) =>
                                                                      user.email ==
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .sender)),
                                                          builder:
                                                              (context, snapshot1) {
                                                            if (snapshot1
                                                                .hasData) {
                                                              return Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          CircleAvatar(
                                                                            backgroundImage:
                                                                                CachedNetworkImageProvider(snapshot1.data!.image),
                                                                            radius:
                                                                                w * 0.06,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                w * 0.02,
                                                                          ),
                                                                          Text(
                                                                            snapshot1.data!.name.capitalize.toString(),
                                                                            style:
                                                                                TextStyle(fontSize: w * 0.045, color: darkMode ? whiteColor : blackColor),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        snapshot1
                                                                            .data!
                                                                            .expertise
                                                                            .capitalize
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: w *
                                                                                0.035,
                                                                            color: darkMode
                                                                                ? whiteColor
                                                                                : blackColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    DateFormat
                                                                            .yMMMd()
                                                                        .add_jm()
                                                                        .format(snapshot
                                                                            .data![index]
                                                                            .time
                                                                            .toDate()),
                                                                    style: TextStyle(
                                                                        color:
                                                                            orangeColor),
                                                                  )
                                                                ],
                                                              );
                                                            } else {
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          });
                                                    }
                                                  }),
                                            ),
                                          ),
                                          SizedBox(height: w * 0.015),
                                        ],
                                      );
                                    })
                                : Column(
                                    children: [
                                      SizedBox(height: w * 0.1),
                                      Text(
                                        "✌️",
                                        style: TextStyle(fontSize: w * 0.065),
                                      ),
                                      Text(
                                        "You don't have any received request.",
                                        style: TextStyle(
                                            fontSize: w * 0.04,
                                            color: darkMode
                                                ? whiteColor
                                                : blackColor),
                                      ),
                                    ],
                                  );
                          } else {
                            return Center(
                              child: CircularProgressIndicator()
                            );
                          }
                        },
                      )
                    : StreamBuilder<List<RequestModel>>(
                        stream: controller.getAcceptedRequest(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.length != 0
                                ? ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => SenderDetailsPage(
                                                          sender: snapshot
                                                                      .data![
                                                                          index]
                                                                      .receiver ==
                                                                  AuthRepository
                                                                      .instance
                                                                      .firebaseUser
                                                                      .value!
                                                                      .email
                                                              ? snapshot
                                                                  .data![index]
                                                                  .sender
                                                              : snapshot
                                                                  .data![index]
                                                                  .receiver,
                                                          id: snapshot
                                                              .data![index].id,
                                                          status: snapshot
                                                              .data![index]
                                                              .status,
                                                          receiver: snapshot
                                                                      .data![
                                                                          index]
                                                                      .sender ==
                                                                  AuthRepository
                                                                      .instance
                                                                      .firebaseUser
                                                                      .value!
                                                                      .email
                                                              ? snapshot
                                                                  .data![index]
                                                                  .receiver
                                                              : snapshot
                                                                  .data![index]
                                                                  .sender)),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: darkMode
                                                    ? inputDarkColor
                                                    : whiteColor,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: w * 0.04,
                                                    horizontal: w * 0.04),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                elevation: 2,
                                              ),
                                              child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("Recruiters")
                                                      .snapshots()
                                                      .map((snapshot1) => snapshot1
                                                          .docs
                                                          .map((e) => RecruiterModel
                                                              .fromSnapshot(e))
                                                          .singleWhere((user) =>
                                                              (user.email == snapshot.data![index].receiver || user.email == snapshot.data![index].sender) &&
                                                              user.email !=
                                                                  AuthRepository
                                                                      .instance
                                                                      .firebaseUser
                                                                      .value!
                                                                      .email)),
                                                  builder: (context, snapshot1) {
                                                    if (snapshot1.hasData) {
                                                      return Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage:
                                                                        CachedNetworkImageProvider(snapshot1
                                                                            .data!
                                                                            .image),
                                                                    radius: w *
                                                                        0.06,
                                                                  ),
                                                                  SizedBox(
                                                                    width: w *
                                                                        0.02,
                                                                  ),
                                                                  Text(
                                                                    snapshot1
                                                                        .data!
                                                                        .name
                                                                        .capitalize
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: w *
                                                                            0.045,
                                                                        color: darkMode
                                                                            ? whiteColor
                                                                            : blackColor),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                snapshot1
                                                                    .data!
                                                                    .company
                                                                    .capitalize
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: w *
                                                                        0.035,
                                                                    color: darkMode
                                                                        ? whiteColor
                                                                        : blackColor),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            DateFormat.yMMMd()
                                                                .add_jm()
                                                                .format(snapshot
                                                                    .data![
                                                                        index]
                                                                    .time
                                                                    .toDate()),
                                                            style: TextStyle(
                                                                color:
                                                                    orangeColor),
                                                          )
                                                        ],
                                                      );
                                                    } else {
                                                      return StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Users")
                                                              .snapshots()
                                                              .map((snapshot1) => snapshot1.docs
                                                                  .map((e) =>
                                                                      UserModel.fromSnapshot(
                                                                          e))
                                                                  .singleWhere((user) =>
                                                                      (user.email == snapshot.data![index].receiver || user.email == snapshot.data![index].sender) &&
                                                                      user.email !=
                                                                          AuthRepository
                                                                              .instance
                                                                              .firebaseUser
                                                                              .value!
                                                                              .email)),
                                                          builder: (context, snapshot1) {
                                                            if (snapshot1
                                                                .hasData) {
                                                              return Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          CircleAvatar(
                                                                            backgroundImage:
                                                                                CachedNetworkImageProvider(snapshot1.data!.image),
                                                                            radius:
                                                                                w * 0.06,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                w * 0.02,
                                                                          ),
                                                                          Text(
                                                                            snapshot1.data!.name.capitalize.toString(),
                                                                            style:
                                                                                TextStyle(fontSize: w * 0.045, color: darkMode ? whiteColor : blackColor),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        snapshot1
                                                                            .data!
                                                                            .expertise
                                                                            .capitalize
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: w *
                                                                                0.035,
                                                                            color: darkMode
                                                                                ? whiteColor
                                                                                : blackColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    DateFormat
                                                                            .yMMMd()
                                                                        .add_jm()
                                                                        .format(snapshot
                                                                            .data![index]
                                                                            .time
                                                                            .toDate()),
                                                                    style: TextStyle(
                                                                        color:
                                                                            orangeColor),
                                                                  )
                                                                ],
                                                              );
                                                            } else {
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            }
                                                          });
                                                    }
                                                  }),
                                            ),
                                          ),
                                          SizedBox(height: w * 0.015),
                                        ],
                                      );
                                    })
                                : Column(
                                    children: [
                                      SizedBox(height: w * 0.1),
                                      Text(
                                        "✌️",
                                        style: TextStyle(fontSize: w * 0.065),
                                      ),
                                      Text(
                                        "You have no accepted request.",
                                        style: TextStyle(
                                            fontSize: w * 0.04,
                                            color: darkMode
                                                ? whiteColor
                                                : blackColor),
                                      ),
                                    ],
                                  );
                          } else {
                            return Center(
                              child: CircularProgressIndicator()
                            );
                          }
                        },
                      )
          ],
        ),
      ),
    );
  }
}
