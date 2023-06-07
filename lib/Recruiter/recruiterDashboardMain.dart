import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Recruiter/recruiterDetail.dart';
import 'package:mca_app_1/Repository/Database/recruiterModel.dart';
import 'package:mca_app_1/Repository/Database/recruiterRepository.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/Repository/Database/userRepository.dart';
import 'package:mca_app_1/User/userDetail.dart';
import 'package:mca_app_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecruiterDashboardMain extends StatefulWidget {
  @override
  State<RecruiterDashboardMain> createState() => _RecruiterDashboardMainState();
}

class _RecruiterDashboardMainState extends State<RecruiterDashboardMain> {
  final controller = Get.put(UserRepository());

  _saveBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("setGrid", setGrid);
  }

  bool checkBox = false;

  TextEditingController _searchController = TextEditingController();
  String _searchValue = '';

  FocusNode _focusNode = FocusNode();

  List<String> selectedExpertise = [];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.height;
    final mqw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
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
                      fontSize: 18, color: darkMode ? whiteColor : blackColor),
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
                    "Candidates :",
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
                  child: StreamBuilder<List<UserModel>>(
                      stream: controller.getUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<UserModel> filteredData = snapshot.data!
                              .where((element) => element.name
                                  .toLowerCase()
                                  .contains(_searchValue.toLowerCase()))
                              .where((element) =>
                                  selectedExpertise.isEmpty ||
                                  selectedExpertise.contains(element.expertise))
                              .toList();
                          return setGrid
                              ? GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
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
                                            builder: (context) => UserDetail(
                                                user: filteredData[index]),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: mq * 0.025,
                                            horizontal: mqw * 0.025),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        elevation: 2,
                                        backgroundColor: darkMode
                                            ? inputDarkColor
                                            : whiteColor,
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: CachedNetworkImageProvider(
                                                filteredData[index].image),
                                            radius: 35,
                                          ),
                                          SizedBox(
                                            height: mq * 0.015,
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
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: mq * 0.015,
                                          ),
                                          Text(
                                            "expertise : ".toUpperCase() +
                                                filteredData[index]
                                                    .expertise
                                                    .toUpperCase(),
                                            style: TextStyle(
                                                color: darkMode
                                                    ? whiteColor
                                                    : blackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: mq * 0.015,
                                          ),
                                          Text(
                                            "experience : ".toUpperCase() +
                                                filteredData[index]
                                                    .experience
                                                    .toUpperCase(),
                                            style: TextStyle(
                                                color: darkMode
                                                    ? whiteColor
                                                    : blackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: filteredData.length,
                                  physics: NeverScrollableScrollPhysics(),
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
                                                    UserDetail(
                                                        user: filteredData[
                                                            index]),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: darkMode
                                                ? inputDarkColor
                                                : whiteColor,
                                            padding: EdgeInsets.symmetric(
                                                vertical: mq * 0.015,
                                                horizontal: mqw * 0.025),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            elevation: 2,
                                          ),
                                          child: Column(
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
                                                    width: mqw * 0.025,
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
                                              SizedBox(
                                                height: mq * 0.01,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "expertise : "
                                                            .toUpperCase() +
                                                        filteredData[index]
                                                            .expertise
                                                            .toUpperCase(),
                                                    style: TextStyle(
                                                        color: darkMode
                                                            ? whiteColor
                                                            : blackColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "experience : "
                                                            .toUpperCase() +
                                                        filteredData[index]
                                                            .experience
                                                            .toUpperCase(),
                                                    style: TextStyle(
                                                        color: darkMode
                                                            ? whiteColor
                                                            : blackColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
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
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(builder: (context) {
        return Container(
          width: mqw * 0.4,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                Scaffold.of(context).openDrawer();
              });
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: mq * 0.015, horizontal: mqw * 0.025),
                elevation: 10,
                backgroundColor: darkMode ? orangeColor : blackColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter",
                  style: TextStyle(
                      fontSize: 20, color: darkMode ? blackColor : whiteColor),
                ),
                Icon(Icons.filter_list,
                    color: darkMode ? blackColor : whiteColor)
              ],
            ),
          ),
        );
      }),
      drawer: Drawer(
        backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 2,
                color: orangeColor,
              ))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.filter_list,
                      size: mqw * 0.08,
                      color: darkMode ? whiteColor : blackColor),
                  SizedBox(
                    width: mqw * 0.015,
                  ),
                  Text(
                    "Filter",
                    style: TextStyle(
                        fontSize: 25,
                        color: darkMode ? whiteColor : blackColor),
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream: controller.getExpertise(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Checkbox(
                                checkColor: darkMode ? blackColor : orangeColor,
                                fillColor: MaterialStateColor.resolveWith(
                                    (_) => darkMode ? orangeColor : blackColor),
                                value: selectedExpertise
                                    .contains(snapshot.data![index]),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value!) {
                                      selectedExpertise = [
                                        ...selectedExpertise,
                                        snapshot.data![index]
                                      ];
                                    } else {
                                      selectedExpertise
                                          .remove(snapshot.data![index]);
                                    }
                                  });
                                },
                              ),
                              Text(
                                snapshot.data![index].toUpperCase(),
                                style: TextStyle(
                                    color: darkMode ? whiteColor : blackColor),
                              ),
                            ],
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
