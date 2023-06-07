import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Admin/adminsList.dart';
import 'package:mca_app_1/Admin/recruitersList.dart';
import 'package:mca_app_1/Admin/usersList.dart';
import 'package:mca_app_1/Repository/Database/adminRepository.dart';
import 'package:mca_app_1/Repository/Database/recruiterRepository.dart';
import 'package:mca_app_1/Repository/Database/userRepository.dart';
import 'package:mca_app_1/main.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final controller = Get.put(AdminRepository());
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: w * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                    stream: controller.getUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            width: w * 0.46,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => UsersList());
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  backgroundColor:
                                      darkMode ? inputDarkColor : whiteColor,
                                  padding:
                                      EdgeInsets.symmetric(vertical: w * 0.03),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      size: w * 0.15,
                                      color: darkMode ? whiteColor : blackColor,
                                    ),
                                    Text(
                                      "Users",
                                      style: TextStyle(
                                        fontSize: w * 0.05,
                                        color:
                                            darkMode ? whiteColor : blackColor,
                                      ),
                                    ),
                                    Text(
                                      "Total : " +
                                          snapshot.data!.length.toString(),
                                      style: TextStyle(
                                        fontSize: w * 0.035,
                                        color:
                                            darkMode ? whiteColor : blackColor,
                                      ),
                                    )
                                  ],
                                )));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                StreamBuilder(
                    stream: controller.getRecruiters(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            width: w * 0.46,
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => RecruitersList());
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  backgroundColor:
                                      darkMode ? inputDarkColor : whiteColor,
                                  padding:
                                      EdgeInsets.symmetric(vertical: w * 0.03),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      size: w * 0.15,
                                      color: darkMode ? whiteColor : blackColor,
                                    ),
                                    Text(
                                      "Recruiters",
                                      style: TextStyle(
                                        fontSize: w * 0.05,
                                        color:
                                            darkMode ? whiteColor : blackColor,
                                      ),
                                    ),
                                    Text(
                                      "Total : " +
                                          snapshot.data!.length.toString(),
                                      style: TextStyle(
                                        fontSize: w * 0.035,
                                        color:
                                            darkMode ? whiteColor : blackColor,
                                      ),
                                    )
                                  ],
                                )));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
            SizedBox(height: w * 0.025),
            StreamBuilder(
                stream: controller.getAdmins(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => AdminsList());
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 3,
                              backgroundColor: orangeColor,
                              padding: EdgeInsets.symmetric(vertical: w * 0.03),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                Icon(Icons.people,
                                    size: w * 0.15,
                                    color: darkMode ? blackColor : whiteColor),
                                Text(
                                  "Admins",
                                  style: TextStyle(
                                      fontSize: w * 0.05,
                                      color:
                                          darkMode ? blackColor : whiteColor),
                                ),
                                Text(
                                  "Total : " + snapshot.data!.length.toString(),
                                  style: TextStyle(
                                      fontSize: w * 0.035,
                                      color:
                                          darkMode ? blackColor : whiteColor),
                                )
                              ],
                            )));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            SizedBox(height: w * 0.05),
            Text(
              "Your activity :",
              style: TextStyle(
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.w500,
                  color: darkMode ? whiteColor : blackColor),
            ),
            SizedBox(height: w * 0.025),
            StreamBuilder(
                stream: controller.getAdminDetails(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.75,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: darkMode ? inputDarkColor : whiteColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Created Users",
                                    style: TextStyle(
                                        fontSize: w * 0.045,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.19,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!.createdUser.toString(),
                                  style: TextStyle(
                                      fontSize: w * 0.045,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: w * 0.025,
                        ),
                        Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.75,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: darkMode ? inputDarkColor : whiteColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Deleted Users",
                                    style: TextStyle(
                                        fontSize: w * 0.045,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.19,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!.deletedUser.toString(),
                                  style: TextStyle(
                                      fontSize: w * 0.045,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: w * 0.025,
                        ),
                        Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.75,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: darkMode ? inputDarkColor : whiteColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Created Recruiters",
                                    style: TextStyle(
                                        fontSize: w * 0.045,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.19,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!.createdRecruiter.toString(),
                                  style: TextStyle(
                                      fontSize: w * 0.045,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: w * 0.025,
                        ),
                        Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.75,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: darkMode ? inputDarkColor : whiteColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Deleted Recruiters",
                                    style: TextStyle(
                                        fontSize: w * 0.045,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.19,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!.deletedRecruiter.toString(),
                                  style: TextStyle(
                                      fontSize: w * 0.045,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: w * 0.025,
                        ),
                        Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.75,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: darkMode ? inputDarkColor : whiteColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Created Admins",
                                    style: TextStyle(
                                        fontSize: w * 0.045,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.19,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!.createdAdmin.toString(),
                                  style: TextStyle(
                                      fontSize: w * 0.045,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: w * 0.025,
                        ),
                        Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.75,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: darkMode ? inputDarkColor : whiteColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Deleted Admins",
                                    style: TextStyle(
                                        fontSize: w * 0.045,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.03),
                              width: w * 0.19,
                              height: w * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!.deletedAdmin.toString(),
                                  style: TextStyle(
                                      fontSize: w * 0.045,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: w * 0.025,
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
    );
  }
}
