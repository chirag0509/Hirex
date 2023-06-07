import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Chats/chatDetails.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/adminModel.dart';
import 'package:mca_app_1/Repository/Database/adminRepository.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/requestModel.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/Repository/Database/userRepository.dart';
import 'package:mca_app_1/main.dart';

class AdminDetail extends StatefulWidget {
  final AdminModel user;
  AdminDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<AdminDetail> createState() => _AdminDetailState();
}

class _AdminDetailState extends State<AdminDetail> {
  Stream<AdminModel> getAdminDetails() {
    final email = AuthRepository.instance.firebaseUser.value?.email;
    return FirebaseFirestore.instance
        .collection("Admins")
        .where("email", isEqualTo: widget.user.email)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => AdminModel.fromSnapshot(e)).single);
  }

  final controller = Get.put(AdminRepository());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
        iconTheme: IconThemeData(color: darkMode ? whiteColor : blackColor),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(widget.user.image),
                      radius: 60,
                    ),
                    SizedBox(
                      height: w * 0.02,
                    ),
                    Text(
                      widget.user.name.toUpperCase(),
                      style: TextStyle(
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.w500,
                          color: darkMode ? whiteColor : blackColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: w * 0.1,
              ),
              Text(
                "● Email : " + widget.user.email.capitalize.toString(),
                style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w500,
                    color: darkMode ? whiteColor : blackColor),
              ),
              SizedBox(
                height: w * 0.05,
              ),
              StreamBuilder(
                  stream: getAdminDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          SizedBox(
                            height: w * 0.025,
                          ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          SizedBox(
                            height: w * 0.025,
                          ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          snapshot.data!.createdAdmin
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          snapshot.data!.deletedAdmin
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: w * 0.045,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ]),
                                ),
                              ]),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
              SizedBox(
                height: w * 0.05,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseFirestore.instance
                            .collection("Admins")
                            .doc(widget.user.id)
                            .delete();
                        Navigator.pop(context);
                        Get.snackbar("success", "success");
                      } catch (e) {
                        Get.snackbar("success", "e");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: whiteColor),
                    )),
              ),
              SizedBox(
                height: w * 0.05,
              ),
            ])),
      ),
    ));
  }
}
