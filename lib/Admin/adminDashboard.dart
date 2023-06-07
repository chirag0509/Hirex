import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Admin/adminSupport.dart';
import 'package:mca_app_1/Admin/adminHome.dart';
import 'package:mca_app_1/Admin/adminProfile.dart';
import 'package:mca_app_1/Chats/chat.dart';
import 'package:mca_app_1/OffPages/helpScreen.dart';
import 'package:mca_app_1/OffPages/privacy.dart';
import 'package:mca_app_1/OffPages/terms.dart';
import 'package:mca_app_1/Repository/AuthScreens/supportScreen.dart';
import 'package:mca_app_1/Repository/Database/adminModel.dart';
import 'package:mca_app_1/Repository/Database/adminRepository.dart';
import 'package:mca_app_1/Repository/Database/requestRepository.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/Repository/Database/userRepository.dart';
import 'package:mca_app_1/User/userDashboardMain.dart';
import 'package:mca_app_1/User/userProfile.dart';
import 'package:mca_app_1/User/userDocuments.dart';
import 'package:mca_app_1/Requests/request.dart';
import 'package:mca_app_1/User/userSettings.dart';
import 'package:mca_app_1/main.dart';

class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final controller = Get.put(AdminRepository());
  final reController = Get.put(RequestRepository());

  @override
  void initState() {
    super.initState();
  }

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
        Icons.message,
      ),
      label: 'Message',
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
    final mq = MediaQuery.of(context).size.height;
    final mqw = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
      appBar: AppBar(
        toolbarHeight: mq * 0.08,
        iconTheme: IconThemeData(color: darkMode ? whiteColor : blackColor),
        actions: [
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        height: mq * 0.7,
                        padding: EdgeInsets.symmetric(
                            vertical: mq * 0.02, horizontal: mqw * 0.03),
                        color: darkMode ? blackColor : whiteColor,
                        child: StreamBuilder(
                            stream: controller.getAdminDetails(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.orange,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(snapshot.data!.image),
                                        radius: 65,
                                      ),
                                    ),
                                    SizedBox(
                                      height: mq * 0.015,
                                    ),
                                    Text(
                                      snapshot.data!.name.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: darkMode
                                              ? whiteColor
                                              : blackColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: mq * 0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.create,
                                              color: orangeColor,
                                            ),
                                            Text(
                                              "Created User",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot.data!.createdUser
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.delete_forever,
                                              color: orangeColor,
                                            ),
                                            Text(
                                              "Deleted User",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot.data!.deletedUser
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.create,
                                              color: orangeColor,
                                            ),
                                            Text(
                                              "Created Recruiter",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot.data!.createdRecruiter
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.delete_forever,
                                              color: orangeColor,
                                            ),
                                            Text(
                                              "Deleted Recruiter",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot.data!.deletedRecruiter
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.create,
                                              color: orangeColor,
                                            ),
                                            Text(
                                              "Created Admin",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot.data!.createdAdmin
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.delete_forever,
                                              color: orangeColor,
                                            ),
                                            Text(
                                              "Deleted Admin",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              snapshot.data!.deletedAdmin
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkMode
                                                      ? whiteColor
                                                      : blackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
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
              stream: controller.getAdminDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(snapshot.data!.image),
                    radius: mqw * 0.06,
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
            width: mqw * 0.015,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PageView(
        controller: recruiterPageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: [
          AdminHome(),
          AdminSupport(),
          AdminProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromARGB(255, 145, 145, 145),
        backgroundColor: darkMode ? Colors.black : whiteColor,
        selectedItemColor: Colors.orange,
        items: _bottomNavigationBarItems,
        iconSize: mqw * 0.075,
        currentIndex: _currentIndex,
        onTap: (index) {
          recruiterPageController.animateToPage(index,
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
                      horizontal: mqw * 0.05, vertical: mqw * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.question_answer,
                        size: mqw * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: mqw * 0.015),
                    Text(
                      "FAQ",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: mqw * 0.045,
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
                      horizontal: mqw * 0.05, vertical: mqw * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.contact_support_sharp,
                        size: mqw * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: mqw * 0.015),
                    Text(
                      "Support",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: mqw * 0.045,
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
                      horizontal: mqw * 0.05, vertical: mqw * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.privacy_tip,
                        size: mqw * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: mqw * 0.015),
                    Text(
                      "Privacy",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: mqw * 0.045,
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
                      horizontal: mqw * 0.05, vertical: mqw * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.file_copy,
                        size: mqw * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: mqw * 0.015),
                    Text(
                      "T&C",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: mqw * 0.045,
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
                      horizontal: mqw * 0.05, vertical: mqw * 0.04),
                ),
                child: Row(
                  children: [
                    Icon(Icons.settings,
                        size: mqw * 0.05,
                        color: darkMode ? whiteColor : blackColor),
                    SizedBox(width: mqw * 0.015),
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: mqw * 0.045,
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
