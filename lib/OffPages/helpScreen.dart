import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/AuthScreens/supportScreen.dart';
import 'package:mca_app_1/Repository/Database/faqModel.dart';
import 'package:mca_app_1/main.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.height;
    final mqw = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: mq * 0.03, horizontal: mqw * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: mqw * 0.25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: darkMode ? whiteColor : blackColor,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      "FAQ",
                      style: TextStyle(
                          color: darkMode ? whiteColor : blackColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => SupportScreen());
                    },
                    child: Row(
                      children: [
                        Text(
                          "Support",
                          style: TextStyle(
                            fontSize: 20,
                            color: darkMode ? blackColor : whiteColor,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: darkMode ? blackColor : whiteColor,
                          size: 20,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkMode ? orangeColor : blackColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 5,
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: mq * 1,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Faq")
                        .orderBy("time", descending: false)
                        .snapshots()
                        .map((snapshot) => snapshot.docs
                            .map((e) => FaqModel.fromSnapshot(e))
                            .toList()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mqw * 0.07),
                                child: Container(
                                  margin: EdgeInsets.only(top: mq * 0.015),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.orange, width: 1))),
                                  child: ExpansionTile(
                                      title: Text(
                                        snapshot.data![index].questionNum +
                                            "  " +
                                            snapshot.data![index].question,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: darkMode
                                              ? whiteColor
                                              : blackColor,
                                        ),
                                      ),
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: mqw * 0.12,
                                              right: mqw * 0.12,
                                              bottom: mq * 0.01),
                                          child: Text(
                                            snapshot.data![index].answer,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: darkMode
                                                  ? whiteColor
                                                  : blackColor,
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
