import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Chats/chatDetails.dart';
import 'package:mca_app_1/Repository/Database/requestModel.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/Repository/Database/userRepository.dart';
import 'package:mca_app_1/main.dart';

class UserDetailForAdmin extends StatefulWidget {
  final UserModel user;
  UserDetailForAdmin({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetailForAdmin> createState() => _UserDetailForAdminState();
}

class _UserDetailForAdminState extends State<UserDetailForAdmin> {
  final controller = Get.put(UserRepository());

  Stream<List<RequestModel>> getUserSendRequest() {
    return FirebaseFirestore.instance.collection("Requests").snapshots().map(
        (snapshot) => snapshot.docs
            .map((e) => RequestModel.fromSnapshot(e))
            .where((user) => user.sender == widget.user.email)
            .toList());
  }

  Stream<List<RequestModel>> getUserReceivedRequest() {
    return FirebaseFirestore.instance.collection("Requests").snapshots().map(
        (snapshot) => snapshot.docs
            .map((e) => RequestModel.fromSnapshot(e))
            .where((user) => user.receiver == widget.user.email)
            .toList());
  }

  Stream<List<RequestModel>> getUserAcceptedRequest() {
    return FirebaseFirestore.instance.collection("Requests").snapshots().map(
        (snapshot) => snapshot.docs
            .map((e) => RequestModel.fromSnapshot(e))
            .where((user) =>
                (user.sender == widget.user.email &&
                    user.status == "accepted") ||
                (user.receiver == widget.user.email &&
                    user.status == "accepted"))
            .toList());
  }

  Stream<List<RequestModel>> getUserRejectedRequest() {
    return FirebaseFirestore.instance.collection("Requests").snapshots().map(
        (snapshot) => snapshot.docs
            .map((e) => RequestModel.fromSnapshot(e))
            .where((user) =>
                (user.sender == widget.user.email &&
                    user.status == "rejected") ||
                (user.receiver == widget.user.email &&
                    user.status == "rejected"))
            .toList());
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text(
                  "● Phone : " + widget.user.phone.capitalize.toString(),
                  style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? whiteColor : blackColor),
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                Text(
                  "● Experience : " +
                      widget.user.experience.capitalize.toString(),
                  style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? whiteColor : blackColor),
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                Text(
                  "● Expertise : " +
                      widget.user.expertise.capitalize.toString(),
                  style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? whiteColor : blackColor),
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                Text(
                  "● Qualification : " +
                      widget.user.qualification.capitalize.toString(),
                  style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? whiteColor : blackColor),
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                Text(
                  "● Address : " + widget.user.address.capitalize.toString(),
                  style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? whiteColor : blackColor),
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                Text(
                  "● Documents : ",
                  style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? whiteColor : blackColor),
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.2),
                  shrinkWrap: true,
                  itemCount: widget.user.documents!.length,
                  itemBuilder: (context, index) {
                    return Image.asset("assets/images/PDF_image.png");
                  },
                ),
                SizedBox(
                  height: w * 0.1,
                ),
                Text(
                  "● Requests : ",
                  style: TextStyle(
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? whiteColor : blackColor),
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder(
                        stream: getUserSendRequest(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: w * 0.4,
                              height: w * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: orangeColor),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                        angle: 150,
                                        child: Icon(
                                          Icons.send,
                                          size: w * 0.055,
                                        )),
                                    SizedBox(
                                      height: w * 0.025,
                                    ),
                                    Text(
                                      "Send",
                                      style: TextStyle(
                                          fontSize: w * 0.055,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: w * 0.025,
                                    ),
                                    Text(
                                      snapshot.data!.length.toString(),
                                      style: TextStyle(
                                          fontSize: w * 0.055,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ]),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    StreamBuilder(
                        stream: getUserReceivedRequest(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: w * 0.4,
                              height: w * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: orangeColor),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                        angle: 90,
                                        child: Icon(
                                          Icons.send,
                                          size: w * 0.055,
                                        )),
                                    SizedBox(
                                      height: w * 0.025,
                                    ),
                                    Text(
                                      "Received",
                                      style: TextStyle(
                                          fontSize: w * 0.055,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: w * 0.025,
                                    ),
                                    Text(
                                      snapshot.data!.length.toString(),
                                      style: TextStyle(
                                          fontSize: w * 0.055,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ]),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder(
                        stream: getUserAcceptedRequest(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: w * 0.4,
                              height: w * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.handshake,
                                      size: w * 0.055,
                                    ),
                                    SizedBox(
                                      height: w * 0.025,
                                    ),
                                    Text(
                                      "Accepted",
                                      style: TextStyle(
                                          fontSize: w * 0.055,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: w * 0.025,
                                    ),
                                    Text(
                                      snapshot.data!.length.toString(),
                                      style: TextStyle(
                                          fontSize: w * 0.055,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ]),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    StreamBuilder(
                        stream: getUserRejectedRequest(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              width: w * 0.4,
                              height: w * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.red),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.close,
                                      size: w * 0.055,
                                    ),
                                    SizedBox(
                                      height: w * 0.025,
                                    ),
                                    Text(
                                      "Rejected",
                                      style: TextStyle(
                                          fontSize: w * 0.055,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: w * 0.025,
                                    ),
                                    Text(
                                      snapshot.data!.length.toString(),
                                      style: TextStyle(
                                          fontSize: w * 0.055,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ]),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
                SizedBox(
                  height: w * 0.05,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseFirestore.instance
                              .collection("Users")
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
