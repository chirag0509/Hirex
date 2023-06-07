import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Admin/adminDashboard.dart';
import 'package:mca_app_1/Recruiter/recruiterDashboard.dart';
import 'package:mca_app_1/User/userDashboard.dart';
import 'package:mca_app_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  _saveBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", darkMode);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: IconButton(
            onPressed: () {
              isSwitched
                  ? Get.offAll(() => RecruiterDashboard())
                  : isAdmin
                      ? Get.offAll(() => AdminDashboard())
                      : Get.offAll(() => UserDashboard());
            },
            icon: Icon(
              Icons.arrow_back,
              color: darkMode ? whiteColor : blackColor,
            )),
      ),
      body: Column(
        children: [
          Text(
            "Settings",
            style: TextStyle(
              fontSize: w * 0.055,
              fontWeight: FontWeight.w500,
              color: darkMode ? whiteColor : blackColor,
            ),
          ),
          SizedBox(
            height: w * 0.03,
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: w * 0.03, vertical: w * 0.02),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              width: 1,
              color: darkMode ? whiteColor : blackColor,
            ))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontWeight: FontWeight.w500,
                    color: darkMode ? whiteColor : blackColor,
                  ),
                ),
                Transform.scale(
                  scale: 0.9,
                  child: CupertinoSwitch(
                      value: darkMode,
                      activeColor: orangeColor,
                      onChanged: (bool value) {
                        setState(() {
                          darkMode = value;
                          _saveBool();
                        });
                      }),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
