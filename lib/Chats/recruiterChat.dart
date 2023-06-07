import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Chats/chatDetails.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/chatModel.dart';
import 'package:mca_app_1/Repository/Database/chatRepository.dart';
import 'package:intl/intl.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/main.dart';

class RecruiterChat extends StatefulWidget {
  const RecruiterChat({super.key});

  @override
  State<RecruiterChat> createState() => _RecruiterChatState();
}

class _RecruiterChatState extends State<RecruiterChat> {
  final controller = Get.put(ChatRepository());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: StreamBuilder(
          stream: controller.getUserChats(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Stream<List<UserModel>> getUser() {
                      return FirebaseFirestore.instance
                          .collection("Users")
                          .snapshots()
                          .map((snapshot1) => snapshot1.docs
                              .map((e) => UserModel.fromSnapshot(e))
                              .where(
                                  (user) => user.email == snapshot.data![index])
                              .toList());
                    }

                    return StreamBuilder<List<UserModel>>(
                        stream: getUser(),
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData) {
                            return ListView.builder(
                                itemCount: snapshot1.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatDetails(
                                                      sender: snapshot1
                                                          .data![index].email,
                                                      name: snapshot1
                                                          .data![index].name,
                                                      image: snapshot1
                                                          .data![index].image,
                                                    )),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: darkMode
                                              ? inputDarkColor
                                              : whiteColor,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: w * 0.03,
                                              horizontal: w * 0.04),
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: CachedNetworkImageProvider(
                                                  snapshot1.data![index].image),
                                              radius: w * 0.06,
                                            ),
                                            SizedBox(width: w * 0.025),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot1.data![index].name
                                                      .capitalize
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: w * 0.045,
                                                      color: darkMode
                                                          ? whiteColor
                                                          : blackColor),
                                                ),
                                                SizedBox(height: w * 0.025),
                                                Container(
                                                  width: w * 0.7,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot1.data![index]
                                                            .email.capitalize
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: w * 0.035,
                                                            color: darkMode
                                                                ? whiteColor
                                                                : blackColor),
                                                      ),
                                                      Text(
                                                        snapshot1
                                                            .data![index]
                                                            .expertise
                                                            .capitalize
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: w * 0.035,
                                                            color: darkMode
                                                                ? whiteColor
                                                                : blackColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: w * 0.015),
                                    ],
                                  );
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
