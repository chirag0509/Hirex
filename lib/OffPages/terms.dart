import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mca_app_1/main.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkMode ? whiteColor : blackColor),
        backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          "Terms and Conditions",
          style: TextStyle(color: darkMode ? whiteColor : blackColor),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.03),
        child: Column(
          children: [
            Text(
              "PURPOSE:",
              style: TextStyle(color: orangeColor, fontSize: w * 0.05),
            ),
            SizedBox(
              height: w * 0.015,
            ),
            Text(
              "HireX.com is intended only to serve as a preliminary medium of contact and exchange of information for its users / members / visitors who have a bona fide intention to contact and/or be contacted for the purposes related to genuine existing job vacancies and for other career enhancement services",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            SizedBox(
              height: w * 0.05,
            ),
            Text(
              "USE TO BE IN CONFORMITY WITH THE PURPOSE",
              style: TextStyle(color: orangeColor, fontSize: w * 0.05),
            ),
            SizedBox(
              height: w * 0.015,
            ),
            Text(
              "HireX.com (and related products) or service or product that is subscribe to or used (whether the same is paid for by you or not) is meant for the Purpose  and only the exclusive use of the subscriber/registered user. Copying or downloading or recreating or sharing passwords or sublicensing or sharing in any manner which is not in accordance with these terms, is a misuse of the platform or service or product and IEIL reserves its rights to act in such manner as to protect its loss of revenue or reputation or claim damages including stopping your service or access and reporting to relevant authorities. In the event you are found to be copying or misusing or transmitting or crawling any data or photographs or graphics or any information available on HireX.com for any purpose other than that being a bonafide Purpose, we reserve the right to take such action that we deem fit including stopping access and claiming damages",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            SizedBox(
              height: w * 0.05,
            ),
            Text(
              "THE USER REPRESENTS, WARRANTS AND COVENANTS THAT ITS USE OF HireX.COM SHALL NOT BE DONE IN A MANNER SO AS TO",
              style: TextStyle(color: orangeColor, fontSize: w * 0.05),
            ),
            SizedBox(
              height: w * 0.015,
            ),
            Text(
              "Violate any applicable local, provincial, state, national or international law, statute, ordinance, rule or regulation;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Interfere with or disrupt computer networks connected to HireX.com;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Impersonate any other person or entity, or make any misrepresentation as to your employment by or affiliation with any other person or entity;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Forge headers or in any manner manipulate identifiers in order to disguise the origin of any user information;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Interfere with or disrupt the use of HireX.com by any other user, nor 'stalk', threaten, or in any manner harass another user;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Use HireX.com in such a manner as to gain unauthorized entry or access to the computer systems of others;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Reproduce, copy, modify, sell, store, distribute or otherwise exploit for any commercial purposes HireX.com, or any component thereof (including, but not limited to any materials or information accessible through HireX.com);",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            SizedBox(
              height: w * 0.05,
            ),
          ],
        ),
      )),
    ));
  }
}
