import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/AuthScreens/loginScreen.dart';
import 'package:mca_app_1/Repository/AuthScreens/registerScreen.dart';
import 'package:mca_app_1/main.dart';
import 'package:mca_app_1/routes.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showGif = true;
  double _opacity = 0.0;
  double _opacity1 = 0.0;
  double _width = 150;
  double _width1 = 150;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showGif = false;
      });
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
        _width = 500;
      });
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _opacity1 = 1.0;
        _width1 = 500;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.07),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: w * 0.25,
                    ),
                    _showGif
                        ? Image.asset(
                            "assets/animations/logo.gif",
                            width: w * 1,
                          )
                        : Image.asset(
                            "assets/images/logo.png",
                            width: w * 1,
                          ),
                  ],
                ),
                Column(
                  children: [
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 750),
                      opacity: _opacity,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 750),
                        width: _width,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => LoginScreen());
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: whiteColor, fontSize: w * 0.065),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding:
                                  EdgeInsets.symmetric(vertical: w * 0.035),
                              backgroundColor: blackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(w * 1)),
                              elevation: 5,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.03,
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 750),
                      opacity: _opacity1,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 750),
                        width: _width1,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => RegisterScreen());
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: blackColor, fontSize: w * 0.065),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding:
                                  EdgeInsets.symmetric(vertical: w * 0.035),
                              backgroundColor: orangeColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(w * 1)),
                              elevation: 5,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.15,
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
