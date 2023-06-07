import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Admin/supportDetail.dart';
import 'package:mca_app_1/Repository/Database/supportRepository.dart';
import 'package:mca_app_1/main.dart';

class AdminSupport extends StatefulWidget {
  @override
  State<AdminSupport> createState() => _AdminSupportState();
}

class _AdminSupportState extends State<AdminSupport> {
  final controller = Get.put(SupportRepository());
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: StreamBuilder(
          stream: controller.getSupport(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => SupportDetail(
                                email: snapshot.data![index].email,
                                name: snapshot.data![index].name,
                                subject: snapshot.data![index].subject,
                                id: snapshot.data![index].id,
                                message: snapshot.data![index].message));
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor:
                                  darkMode ? inputDarkColor : whiteColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.05, vertical: w * 0.055)),
                          child: Row(
                            children: [
                              Text(
                                snapshot.data![index].subject.capitalize
                                    .toString(),
                                style: TextStyle(
                                    color: darkMode ? whiteColor : blackColor,
                                    fontSize: w * 0.045,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: w * 0.025,
                        )
                      ],
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
