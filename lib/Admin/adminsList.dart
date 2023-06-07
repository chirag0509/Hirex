import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Admin/adminDashboard.dart';
import 'package:mca_app_1/Admin/adminDetail.dart';
import 'package:mca_app_1/Admin/userDetailForAdmin.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/adminModel.dart';
import 'package:mca_app_1/Repository/Database/adminRepository.dart';
import 'package:mca_app_1/Repository/Database/recruiterRepository.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/Repository/Database/userRepository.dart';
import 'package:mca_app_1/User/userDetail.dart';
import 'package:mca_app_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminsList extends StatefulWidget {
  @override
  State<AdminsList> createState() => _AdminsListState();
}

class _AdminsListState extends State<AdminsList> {
  final controller = Get.put(AdminRepository());
  final authController = Get.put(AuthRepository());

  _saveBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("setGrid", setGrid);
  }

  bool checkBox = false;

  TextEditingController _searchController = TextEditingController();
  String _searchValue = '';

  FocusNode _focusNode = FocusNode();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.height;
    final mqw = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: darkMode ? whiteColor : blackColor,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: mqw * 0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: mq * 0.01),
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    suffixIcon: Icon(Icons.search,
                        color: darkMode ? whiteColor : blackColor),
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: darkMode ? whiteColor : blackColor),
                    fillColor: darkMode ? inputDarkColor : inputLightColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: mq * 0.02, horizontal: mqw * 0.06),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchValue = value;
                    });
                  },
                  focusNode: _focusNode,
                  onFieldSubmitted: (value) {
                    _focusNode.unfocus();
                  },
                ),
                SizedBox(
                  height: mq * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Admins :",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: darkMode ? whiteColor : blackColor),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          setGrid = !setGrid;
                          _saveBool();
                        });
                      },
                      icon: setGrid
                          ? Icon(Icons.list,
                              color: darkMode ? whiteColor : blackColor)
                          : Icon(Icons.grid_on,
                              color: darkMode ? whiteColor : blackColor),
                    )
                  ],
                ),
                Container(
                  height: mq * 0.65,
                  child: SingleChildScrollView(
                    child: StreamBuilder(
                        stream: controller.getAdminDetails(),
                        builder: (context, snapshotAdmin) {
                          if (snapshotAdmin.hasData) {
                            AdminModel admin = snapshotAdmin.data as AdminModel;
                            return StreamBuilder<List<AdminModel>>(
                                stream: controller.getAdmins(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<AdminModel> filteredData = snapshot
                                        .data!
                                        .where((element) => element.name
                                            .toLowerCase()
                                            .contains(
                                                _searchValue.toLowerCase()))
                                        .toList();
                                    return setGrid
                                        ? GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 10,
                                                    crossAxisSpacing: 10,
                                                    childAspectRatio: 0.9),
                                            shrinkWrap: true,
                                            itemCount: filteredData.length,
                                            itemBuilder: (context, index) {
                                              return ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminDetail(
                                                              user:
                                                                  filteredData[
                                                                      index]),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: mq * 0.01,
                                                      horizontal: mqw * 0.01),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  elevation: 2,
                                                  backgroundColor: darkMode
                                                      ? inputDarkColor
                                                      : whiteColor,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "Admins")
                                                                    .doc(filteredData[
                                                                            index]
                                                                        .id)
                                                                    .delete();
                                                                final user = AdminModel(
                                                                    id: admin
                                                                        .id,
                                                                    name: admin
                                                                        .name,
                                                                    email: admin
                                                                        .email,
                                                                    password: admin
                                                                        .password,
                                                                    image: admin
                                                                        .image,
                                                                    createdUser:
                                                                        admin
                                                                            .createdUser,
                                                                    createdAdmin:
                                                                        admin
                                                                            .createdAdmin,
                                                                    createdRecruiter:
                                                                        admin
                                                                            .createdRecruiter,
                                                                    deletedAdmin:
                                                                        admin.deletedAdmin +
                                                                            1,
                                                                    deletedRecruiter:
                                                                        admin
                                                                            .deletedRecruiter,
                                                                    deletedUser:
                                                                        admin
                                                                            .deletedUser);
                                                                controller
                                                                    .updateReAdminRecord(
                                                                        user);
                                                                Get.snackbar(
                                                                    "success",
                                                                    "success");
                                                              } catch (e) {
                                                                Get.snackbar(
                                                                    "success",
                                                                    "e");
                                                              }
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: darkMode
                                                                  ? whiteColor
                                                                  : blackColor,
                                                            ))
                                                      ],
                                                    ),
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          CachedNetworkImageProvider(
                                                              filteredData[
                                                                      index]
                                                                  .image),
                                                      radius: mqw * 0.07,
                                                    ),
                                                    SizedBox(
                                                      height: mqw * 0.05,
                                                    ),
                                                    Text(
                                                      filteredData[index]
                                                          .name
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: darkMode
                                                              ? whiteColor
                                                              : blackColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: filteredData.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AdminDetail(
                                                                  user: filteredData[
                                                                      index]),
                                                        ),
                                                      );
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor: darkMode
                                                          ? inputDarkColor
                                                          : whiteColor,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  mq * 0.015,
                                                              horizontal:
                                                                  mqw * 0.025),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      elevation: 2,
                                                    ),
                                                    child: Column(
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
                                                                          filteredData[index]
                                                                              .image),
                                                                  radius: 25,
                                                                ),
                                                                SizedBox(
                                                                  width: mqw *
                                                                      0.025,
                                                                ),
                                                                Text(
                                                                  filteredData[
                                                                          index]
                                                                      .name
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      color: darkMode
                                                                          ? whiteColor
                                                                          : blackColor,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            ),
                                                            IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  try {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "Admins")
                                                                        .doc(filteredData[index]
                                                                            .id)
                                                                        .delete();
                                                                    final user = AdminModel(
                                                                        id: admin
                                                                            .id,
                                                                        name: admin
                                                                            .name,
                                                                        email: admin
                                                                            .email,
                                                                        password: admin
                                                                            .password,
                                                                        image: admin
                                                                            .image,
                                                                        createdUser: admin
                                                                            .createdUser,
                                                                        createdAdmin:
                                                                            admin
                                                                                .createdAdmin,
                                                                        createdRecruiter:
                                                                            admin
                                                                                .createdRecruiter,
                                                                        deletedAdmin:
                                                                            admin.deletedAdmin +
                                                                                1,
                                                                        deletedRecruiter:
                                                                            admin
                                                                                .deletedRecruiter,
                                                                        deletedUser:
                                                                            admin.deletedUser);
                                                                    controller
                                                                        .updateReAdminRecord(
                                                                            user);
                                                                    Get.snackbar(
                                                                        "success",
                                                                        "success");
                                                                  } catch (e) {
                                                                    Get.snackbar(
                                                                        "success",
                                                                        "e");
                                                                  }
                                                                },
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color: darkMode
                                                                      ? whiteColor
                                                                      : blackColor,
                                                                ))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: mq * 0.01)
                                                ],
                                              );
                                            });
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ),
                SizedBox(height: mq * 0.015),
                StreamBuilder(
                    stream: controller.getAdminDetails(),
                    builder: (context, snapshot) {
                      AdminModel admin = snapshot.data as AdminModel;
                      if (snapshot.hasData) {
                        return Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          height: mqw * 2,
                                          padding: EdgeInsets.symmetric(
                                              vertical: mqw * 0.1,
                                              horizontal: mqw * 0.03),
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: darkMode
                                                        ? whiteColor
                                                        : blackColor),
                                                decoration: InputDecoration(
                                                  hintText: "Name",
                                                  prefixIcon: Icon(Icons.person,
                                                      color: darkMode
                                                          ? whiteColor
                                                          : iconDarkColor),
                                                  hintStyle: TextStyle(
                                                      fontSize: 18,
                                                      color: darkMode
                                                          ? whiteColor
                                                          : blackColor),
                                                  fillColor: darkMode
                                                      ? inputDarkColor
                                                      : inputLightColor,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: mq * 0.02,
                                                          horizontal:
                                                              mqw * 0.06),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .transparent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                ),
                                              ),
                                              SizedBox(height: mq * 0.015),
                                              TextFormField(
                                                controller: email,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: darkMode
                                                        ? whiteColor
                                                        : blackColor),
                                                decoration: InputDecoration(
                                                  hintText: "Email",
                                                  prefixIcon: Icon(Icons.mail,
                                                      color: darkMode
                                                          ? whiteColor
                                                          : iconDarkColor),
                                                  hintStyle: TextStyle(
                                                      fontSize: 18,
                                                      color: darkMode
                                                          ? whiteColor
                                                          : blackColor),
                                                  fillColor: darkMode
                                                      ? inputDarkColor
                                                      : inputLightColor,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: mq * 0.02,
                                                          horizontal:
                                                              mqw * 0.06),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .transparent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                ),
                                              ),
                                              SizedBox(height: mq * 0.015),
                                              TextFormField(
                                                controller: password,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: darkMode
                                                        ? whiteColor
                                                        : blackColor),
                                                decoration: InputDecoration(
                                                  hintText: "Password",
                                                  prefixIcon: Icon(
                                                      Icons.password,
                                                      color: darkMode
                                                          ? whiteColor
                                                          : iconDarkColor),
                                                  hintStyle: TextStyle(
                                                      fontSize: 18,
                                                      color: darkMode
                                                          ? whiteColor
                                                          : blackColor),
                                                  fillColor: darkMode
                                                      ? inputDarkColor
                                                      : inputLightColor,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: mq * 0.02,
                                                          horizontal:
                                                              mqw * 0.06),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .transparent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                ),
                                              ),
                                              SizedBox(height: mq * 0.015),
                                              Container(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      authController
                                                          .createUserforAdmin(
                                                              name.text.trim(),
                                                              email.text.trim(),
                                                              password.text
                                                                  .trim())
                                                          .then((_) => authController
                                                              .signInWithEmailAndPassword(
                                                                  admin.email,
                                                                  admin
                                                                      .password)
                                                              .then((_) => Get.to(
                                                                  AdminsList())));

                                                      final user = AdminModel(
                                                          id: Random()
                                                              .toString(),
                                                          name:
                                                              name.text.trim(),
                                                          email:
                                                              email.text.trim(),
                                                          password: password
                                                              .text
                                                              .trim(),
                                                          createdAdmin: 0,
                                                          createdRecruiter: 0,
                                                          createdUser: 0,
                                                          deletedAdmin: 0,
                                                          deletedRecruiter: 0,
                                                          deletedUser: 0,
                                                          image:
                                                              "https://firebasestorage.googleapis.com/v0/b/miniproject1sem1.appspot.com/o/avatar.png?alt=media&token=ee25b340-fa48-4721-b480-def52626e826");
                                                      await controller
                                                          .createAdmin(user);
                                                      final userNew = AdminModel(
                                                          id: admin.id,
                                                          name: admin.name,
                                                          email: admin.email,
                                                          password:
                                                              admin.password,
                                                          image: admin.image,
                                                          createdUser:
                                                              admin.createdUser,
                                                          createdAdmin: admin
                                                                  .createdAdmin +
                                                              1,
                                                          createdRecruiter: admin
                                                              .createdRecruiter,
                                                          deletedAdmin: admin
                                                              .deletedAdmin,
                                                          deletedRecruiter: admin
                                                              .deletedRecruiter,
                                                          deletedUser: admin
                                                              .deletedUser);
                                                      controller
                                                          .updateReAdminRecord(
                                                              userNew);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Submit",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: darkMode
                                                              ? blackColor
                                                              : whiteColor),
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            darkMode
                                                                ? orangeColor
                                                                : blackColor,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    mq * 0.018),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15))),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                "Add User",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: darkMode ? blackColor : whiteColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      darkMode ? orangeColor : blackColor,
                                  padding: EdgeInsets.symmetric(
                                      vertical: mq * 0.018),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
