import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/recruiterRepository.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/main.dart';
import 'package:image_picker/image_picker.dart';

class RecruiterProfile extends StatefulWidget {
  @override
  State<RecruiterProfile> createState() => _RecruiterProfileState();
}

class _RecruiterProfileState extends State<RecruiterProfile> {
  final controller = Get.put(RecruiterRepository());
  final controller1 = Get.put(AuthRepository());

  bool _isEnabled = false;
  bool _isOtp = false;
  var otp;

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
    final mqw = MediaQuery.of(context).size.width;

    return RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: mqw * 0.04),
            child: StreamBuilder(
              stream: controller.getRecruiterDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  RecruiterModel user = snapshot.data as RecruiterModel;
                  final name =
                      TextEditingController(text: user.name.capitalize);
                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);
                  final phone = TextEditingController(text: user.phone);
                  final address = TextEditingController(text: user.address);
                  final vacancy = TextEditingController(text: user.vacancy);
                  final company =
                      TextEditingController(text: user.company.capitalize);
                  final requirements =
                      TextEditingController(text: user.requirements.capitalize);
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
                                        backgroundImage:
                                            CachedNetworkImageProvider(image),
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
                                      SizedBox(width: mqw * 0.01),
                                      Icon(
                                        Icons.edit,
                                        size: mqw * 0.04,
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
                                vertical: mq * 0.02, horizontal: mqw * 0.06),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: mq * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: mqw * 0.7,
                              child: TextFormField(
                                controller: email,
                                enabled: false,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: darkMode ? whiteColor : blackColor),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email,
                                      color: darkMode
                                          ? whiteColor
                                          : iconDarkColor),
                                  hintStyle: TextStyle(
                                      fontSize: 18,
                                      color:
                                          darkMode ? whiteColor : blackColor),
                                  fillColor: darkMode
                                      ? inputDarkColor
                                      : inputLightColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15)),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: mq * 0.02,
                                      horizontal: mqw * 0.06),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                            AuthRepository
                                    .instance.firebaseUser.value!.emailVerified
                                ? Container(
                                    width: mqw * 0.2,
                                    child: Center(
                                        child: Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: mqw * 0.07,
                                    )),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      if (!_isEnabled) {
                                        Get.snackbar(
                                            'Error', 'First enable editing');
                                      } else {
                                        AuthRepository.instance
                                            .sendEmailVerification();
                                      }
                                    },
                                    child: Text(
                                      "Verify",
                                      style: TextStyle(
                                          fontSize: 18, color: whiteColor),
                                    ),
                                  )
                          ],
                        ),
                        SizedBox(height: mq * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: mqw * 0.7,
                              child: TextFormField(
                                controller: phone,
                                enabled: user.verified == "verified"
                                    ? false
                                    : _isEnabled,
                                style: TextStyle(
                                    color: darkMode ? whiteColor : blackColor),
                                decoration: InputDecoration(
                                  hintText: "Phone",
                                  prefixIcon: Icon(Icons.phone,
                                      color: darkMode
                                          ? whiteColor
                                          : iconDarkColor),
                                  hintStyle: TextStyle(
                                      fontSize: 18,
                                      color:
                                          darkMode ? whiteColor : blackColor),
                                  fillColor: darkMode
                                      ? inputDarkColor
                                      : inputLightColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15)),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: mq * 0.02,
                                      horizontal: mqw * 0.06),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                            user.verified == "verified"
                                ? Container(
                                    width: mqw * 0.2,
                                    child: Center(
                                        child: Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: mqw * 0.07,
                                    )),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      if (!_isEnabled) {
                                        Get.snackbar(
                                            'Error', 'First enable editing');
                                      } else {
                                        setState(() {
                                          _isOtp = true;
                                        });
                                        controller1.phoneAuthentication(
                                            phone.text.trim());
                                        final userNewData = RecruiterModel(
                                            id: user.id,
                                            name: user.name,
                                            email: user.email,
                                            password: user.password,
                                            phone: phone.text.trim(),
                                            company: user.company,
                                            vacancy: user.vacancy,
                                            requirements: user.requirements,
                                            verified: user.verified,
                                            address: user.address,
                                            image: user.image);
                                        controller
                                            .updateRecruiterRecord(userNewData);
                                      }
                                    },
                                    child: Text(
                                      "Verify",
                                      style: TextStyle(
                                          fontSize: 18, color: whiteColor),
                                    ),
                                  )
                          ],
                        ),
                        _isOtp
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: mq * 0.015,
                                  ),
                                  OtpTextField(
                                    fieldWidth: mqw * 0.1,
                                    autoFocus: true,
                                    showFieldAsBox: true,
                                    borderColor: Colors.transparent,
                                    focusedBorderColor: Colors.orange,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    numberOfFields: 6,
                                    fillColor: darkMode
                                        ? inputDarkColor
                                        : inputLightColor,
                                    filled: true,
                                    onSubmit: (code) {
                                      otp = code;

                                      setState(() {
                                        _isOtp = false;
                                      });
                                      AuthRepository.instance.verifyOTP(otp);
                                      final userNewData = RecruiterModel(
                                        id: user.id,
                                        name: user.name,
                                        email: user.email,
                                        password: user.password,
                                        phone: phone.text.trim(),
                                        company: user.company,
                                        vacancy: user.vacancy,
                                        requirements: user.requirements,
                                        address: user.address,
                                        image: user.image,
                                        verified: "verified",
                                      );
                                      controller
                                          .updateRecruiterRecord(userNewData);
                                    },
                                  ),
                                  SizedBox(height: mq * 0.015),
                                ],
                              )
                            : SizedBox(height: mq * 0.015),
                        TextFormField(
                          controller: address,
                          enabled: _isEnabled,
                          style: TextStyle(
                              fontSize: 18,
                              color: darkMode ? whiteColor : blackColor),
                          decoration: InputDecoration(
                            hintText: "Company Address",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Icon(Icons.location_city,
                                  color: darkMode ? whiteColor : iconDarkColor),
                            ),
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
                                vertical: mq * 0.02, horizontal: mqw * 0.06),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(height: mq * 0.015),
                        TextFormField(
                          controller: company,
                          enabled: _isEnabled,
                          style: TextStyle(
                              fontSize: 18,
                              color: darkMode ? whiteColor : blackColor),
                          decoration: InputDecoration(
                            hintText: "Company",
                            prefixIcon: Icon(Icons.school,
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
                                vertical: mq * 0.02, horizontal: mqw * 0.06),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: mq * 0.015),
                        TextFormField(
                          controller: vacancy,
                          enabled: _isEnabled,
                          style: TextStyle(
                              fontSize: 18,
                              color: darkMode ? whiteColor : blackColor),
                          decoration: InputDecoration(
                            hintText: "Vacancy",
                            prefixIcon: Icon(Icons.chair_alt,
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
                                vertical: mq * 0.02, horizontal: mqw * 0.06),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: mq * 0.015),
                        TextFormField(
                          controller: requirements,
                          enabled: _isEnabled,
                          style: TextStyle(
                              fontSize: 18,
                              color: darkMode ? whiteColor : blackColor),
                          decoration: InputDecoration(
                            hintText: "Employee requirements",
                            prefixIcon: Icon(Icons.file_copy,
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
                                vertical: mq * 0.02, horizontal: mqw * 0.06),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        SizedBox(height: mq * 0.015),
                        _isEnabled
                            ? Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final userNewData = RecruiterModel(
                                        id: user.id,
                                        name: name.text.trim(),
                                        email: email.text.trim(),
                                        password: password.text.trim(),
                                        phone: phone.text.trim(),
                                        company: company.text.trim(),
                                        vacancy: vacancy.text.trim(),
                                        requirements: requirements.text.trim(),
                                        address: address.text.trim(),
                                        verified: "verified",
                                        image:
                                            imageUrl == "" ? image : imageUrl,
                                      );
                                      await controller
                                          .updateRecruiterRecord(userNewData);
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
                                    width: mqw * 0.06,
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: EdgeInsets.symmetric(
                                      vertical: mq * 0.018,
                                      horizontal: mqw * 0.03),
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
