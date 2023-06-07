import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mca_app_1/Admin/adminDetail.dart';
import 'package:mca_app_1/Repository/Database/adminModel.dart';
import 'package:mca_app_1/Repository/Database/adminRepository.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/recruiterRepository.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/main.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfile extends StatefulWidget {
  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final controller = Get.put(AdminRepository());
  final controller1 = Get.put(AuthRepository());

  bool _isEnabled = false;

  final _formKey = GlobalKey<FormState>();

  String imageUrl = "";
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  void pickImage() async {
    file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("userImages");
    Reference referenceImagesToUpload =
        referenceDirImages.child(uniqueFileName);
    try {
      await referenceImagesToUpload.putFile(File(file!.path));
      imageUrl = await referenceImagesToUpload.getDownloadURL();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: StreamBuilder(
              stream: controller.getAdminDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AdminModel user = snapshot.data as AdminModel;
                  final name = TextEditingController(text: user.name);
                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);
                  final image = user.image;
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: mq * 0.02),
                        Container(
                          width: double.infinity,
                          color: Color.fromARGB(255, 255, 242, 222),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                if (_isEnabled) {
                                  pickImage();
                                } else {
                                  Get.snackbar(
                                      "Error", "Please enable editing");
                                }
                              },
                              child: file == null
                                  ? CircleAvatar(
                                      radius: 80,
                                      backgroundColor: Colors.orange,
                                      child: CircleAvatar(
                                        backgroundImage: CachedNetworkImageProvider(image),
                                        radius: 75,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 80,
                                      backgroundColor: Colors.orange,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            FileImage(File(file!.path)),
                                        radius: 75,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: mq * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Profile Details :",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: darkMode ? whiteColor : blackColor),
                            ),
                            Visibility(
                              visible: !_isEnabled,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isEnabled = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Edit",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(width: w * 0.01),
                                      Icon(
                                        Icons.edit,
                                        size: w * 0.04,
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                        SizedBox(height: mq * 0.02),
                        TextFormField(
                          controller: name,
                          enabled: _isEnabled,
                          style: TextStyle(
                              fontSize: 18,
                              color: darkMode ? whiteColor : blackColor),
                          decoration: InputDecoration(
                            hintText: "Name",
                            prefixIcon: Icon(Icons.person,
                                color: darkMode ? whiteColor : iconDarkColor),
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: darkMode ? whiteColor : blackColor),
                            fillColor:
                                darkMode ? inputDarkColor : inputLightColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: mq * 0.02, horizontal: w * 0.06),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: mq * 0.015),
                        TextFormField(
                          controller: email,
                          enabled: _isEnabled,
                          style: TextStyle(
                              fontSize: 18,
                              color: darkMode ? whiteColor : blackColor),
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.person,
                                color: darkMode ? whiteColor : iconDarkColor),
                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: darkMode ? whiteColor : blackColor),
                            fillColor:
                                darkMode ? inputDarkColor : inputLightColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: mq * 0.02, horizontal: w * 0.06),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: mq * 0.015),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: w * 0.4,
                                height: w * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.create,
                                        size: w * 0.055,
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        "Created Users",
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        snapshot.data!.createdUser.toString(),
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                              ),
                              Container(
                                width: w * 0.4,
                                height: w * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete_forever,
                                        size: w * 0.055,
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        "Deleted Users",
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        snapshot.data!.deletedUser.toString(),
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                              ),
                            ]),
                        SizedBox(height: mq * 0.015),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: w * 0.4,
                                height: w * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.create,
                                        size: w * 0.055,
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        "Created Recruiters",
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        snapshot.data!.createdRecruiter
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                              ),
                              Container(
                                width: w * 0.4,
                                height: w * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete_forever,
                                        size: w * 0.055,
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        "Deleted Recruiters",
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        snapshot.data!.deletedRecruiter
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                              ),
                            ]),
                        SizedBox(height: mq * 0.015),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: w * 0.4,
                                height: w * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.create,
                                        size: w * 0.055,
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        "Created Admins",
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        snapshot.data!.createdAdmin.toString(),
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                              ),
                              Container(
                                width: w * 0.4,
                                height: w * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete_forever,
                                        size: w * 0.055,
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        "Deleted Admins",
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: w * 0.025,
                                      ),
                                      Text(
                                        snapshot.data!.deletedAdmin.toString(),
                                        style: TextStyle(
                                            fontSize: w * 0.045,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                              ),
                            ]),
                        SizedBox(height: mq * 0.015),
                        _isEnabled
                            ? Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final userNewData = AdminModel(
                                        id: user.id,
                                        name: name.text.trim(),
                                        email: email.text.trim(),
                                        password: password.text.trim(),
                                        createdAdmin: user.createdAdmin,
                                        createdRecruiter: user.createdRecruiter,
                                        createdUser: user.createdUser,
                                        deletedAdmin: user.deletedAdmin,
                                        deletedRecruiter: user.deletedRecruiter,
                                        deletedUser: user.deletedUser,
                                        image:
                                            imageUrl == "" ? image : imageUrl,
                                      );
                                      await controller
                                          .updateReAdminRecord(userNewData);
                                      setState(() {
                                        _isEnabled = false;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            darkMode ? blackColor : whiteColor),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          darkMode ? orangeColor : blackColor,
                                      padding: EdgeInsets.symmetric(
                                          vertical: mq * 0.018),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                ))
                            : Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            darkMode ? whiteColor : blackColor),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: darkMode
                                          ? Colors.white12
                                          : Colors.black38,
                                      padding: EdgeInsets.symmetric(
                                          vertical: mq * 0.018),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                )),
                        SizedBox(height: mq * 0.015),
                        Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                AuthRepository.instance.logout();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.logout),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: w * 0.06,
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: EdgeInsets.symmetric(
                                      vertical: mq * 0.018,
                                      horizontal: w * 0.03),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            )),
                        SizedBox(height: mq * 0.015),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ));
  }
}
