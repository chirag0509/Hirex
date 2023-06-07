import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Chats/recruiterChat.dart';
import 'package:mca_app_1/OffPages/helpScreen.dart';
import 'package:mca_app_1/OffPages/privacy.dart';
import 'package:mca_app_1/OffPages/terms.dart';
import 'package:mca_app_1/Recruiter/recruiterDashboardMain.dart';
import 'package:mca_app_1/Recruiter/recruiterProfile.dart';
import 'package:mca_app_1/Repository/AuthScreens/supportScreen.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/recruiterRepository.dart';
import 'package:mca_app_1/Repository/Database/requestRepository.dart';
import 'package:mca_app_1/Requests/request.dart';
import 'package:mca_app_1/User/userSettings.dart';
import 'package:mca_app_1/main.dart';

class RecruiterDashboard extends StatefulWidget {
  @override
  State<RecruiterDashboard> createState() => _RecruiterDashboardState();
}

class _RecruiterDashboardState extends State<RecruiterDashboard> {
  final controller = Get.put(RecruiterRepository());
  final reController = Get.put(RequestRepository());

  int _currentIndex = 0;

  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.chat_outlined,
      ),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.request_page,
      ),
      label: 'Requests',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person_outlined,
      ),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
      appBar: AppBar(
        toolbarHeight: w * 0.16,
        iconTheme: IconThemeData(color: darkMode ? whiteColor : blackColor),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {});
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        height: w * 1.4,
                        padding: EdgeInsets.symmetric(
                            vertical: w * 0.04, horizontal: w * 0.03),
                        color: darkMode ? blackColor : whiteColor,
                        child: StreamBuilder(
                            stream: controller.getRecruiterDetails(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                RecruiterModel user =
                                    snapshot.data as RecruiterModel;
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: w * 0.15,
                                      backgroundColor: orangeColor,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(user.image),
                                        radius: w * 0.145,
                                      ),
                                    ),
                                    SizedBox(
                                      height: w * 0.03,
                                    ),
                                    Text(
                                      user.name.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: w * 0.05,
                                          color: darkMode
                                              ? whiteColor
                                              : blackColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: w * 0.06,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Transform.rotate(
                                                angle: -45,
                                                child: Icon(
                                                  Icons.send,
                                                  color: orangeColor,
                                                  size: w * 0.05,
                                                )),
                                            Text(
                                              "Sent",
                                              style: TextStyle(
                                                  fontSize: w * 0.045,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            StreamBuilder(
                                                stream: reController
                                                    .getSentRequest(),
                                                builder: (context, snapshot1) {
                                                  if (snapshot1.hasData) {
                                                    return Text(
                                                      snapshot1.data!.length
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: darkMode
                                                              ? whiteColor
                                                              : blackColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    );
                                                  } else {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                }),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Transform.rotate(
                                                angle: 90,
                                                child: Icon(
                                                  Icons.send,
                                                  color: orangeColor,
                                                  size: w * 0.05,
                                                )),
                                            Text(
                                              "Received",
                                              style: TextStyle(
                                                  fontSize: w * 0.045,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            StreamBuilder(
                                                stream: reController
                                                    .getReceivedRequest(),
                                                builder: (context, snapshot1) {
                                                  if (snapshot1.hasData) {
                                                    return Text(
                                                      snapshot1.data!.length
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: darkMode
                                                              ? whiteColor
                                                              : blackColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    );
                                                  } else {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                }),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.handshake,
                                              color: orangeColor,
                                              size: w * 0.05,
                                            ),
                                            Text(
                                              "Accepted",
                                              style: TextStyle(
                                                  fontSize: w * 0.045,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            StreamBuilder(
                                                stream: reController
                                                    .getAcceptedRequest(),
                                                builder: (context, snapshot1) {
                                                  if (snapshot1.hasData) {
                                                    return Text(
                                                      snapshot1.data!.length
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: darkMode
                                                              ? whiteColor
                                                              : blackColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    );
                                                  } else {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                }),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }));
                  });
            },
            child: StreamBuilder(
              stream: controller.getRecruiterDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  RecruiterModel user = snapshot.data as RecruiterModel;
                  final image = user.image;
                  return CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(image),
                    radius: w * 0.06,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          SizedBox(
            width: w * 0.015,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PageView(
        controller: userPageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: [
          RecruiterDashboardMain(),
          RecruiterChat(),
          Request(),
          RecruiterProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromARGB(255, 145, 145, 145),
        backgroundColor: darkMode ? blackColor : whiteColor,
        selectedItemColor: orangeColor,
        items: _bottomNavigationBarItems,
        iconSize: w * 0.075,
        currentIndex: _currentIndex,
        onTap: (index) {
          userPageController.animateToPage(index,
              duration: Duration(microseconds: 300), curve: Curves.ease);
        },
        type: BottomNavigationBarType.fixed,
      ),
      drawer: Drawer(
        backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
        child: Builder(builder: (context) {
          return ListView(children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 1,
                  color: darkMode ? whiteColor : blackColor,
                ))),
                child: Text("Drawer")),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
                color: darkMode ? whiteColor : blackColor,
              ))),
              child: TextButton(
                onPressed: () {
                  Get.to(() => HelpScreen());
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05, vertical: w * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.question_answer,
                        size: w * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: w * 0.015),
                    Text(
                      "FAQ",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: w * 0.045,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
                color: darkMode ? whiteColor : blackColor,
              ))),
              child: TextButton(
                onPressed: () {
                  Get.to(() => SupportScreen());
                },
                style: TextButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05, vertical: w * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.contact_support_sharp,
                        size: w * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: w * 0.015),
                    Text(
                      "Support",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: w * 0.045,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
                color: darkMode ? whiteColor : blackColor,
              ))),
              child: TextButton(
                onPressed: () {
                  Get.to(() => Privacy());
                },
                style: TextButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05, vertical: w * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.privacy_tip,
                        size: w * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: w * 0.015),
                    Text(
                      "Privacy",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: w * 0.045,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
                color: darkMode ? whiteColor : blackColor,
              ))),
              child: TextButton(
                onPressed: () {
                  Get.to(() => Terms());
                },
                style: TextButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05, vertical: w * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.file_copy,
                        size: w * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: w * 0.015),
                    Text(
                      "T&C",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: w * 0.045,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
                color: darkMode ? whiteColor : blackColor,
              ))),
              child: TextButton(
                onPressed: () {
                  Get.to(() => UserSettings());
                  Scaffold.of(context).closeDrawer();
                },
                style: TextButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.05, vertical: w * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.settings,
                        size: w * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: w * 0.015),
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: w * 0.045,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        }),
      ),
    ));
  }
}
