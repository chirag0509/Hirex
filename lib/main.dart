import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Admin/adminDashboard.dart';
import 'package:mca_app_1/Recruiter/recruiterDashboard.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/User/userDashboard.dart';
import 'package:mca_app_1/Repository/AuthScreens/forgetScreen.dart';
import 'package:mca_app_1/OffPages/helpScreen.dart';
import 'package:mca_app_1/Repository/AuthScreens/loginScreen.dart';
import 'package:mca_app_1/Repository/AuthScreens/registerScreen.dart';
import 'package:mca_app_1/routes.dart';
import 'package:mca_app_1/Repository/AuthScreens/supportScreen.dart';
import 'package:mca_app_1/OffPages/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

bool darkMode = false;
bool isSwitched = false;
bool isAdmin = false;
bool setGrid = false;
bool showSent = true;
bool showReceived = false;
PageController userPageController = PageController(initialPage: 0);
PageController recruiterPageController = PageController(initialPage: 0);

Color blackColor = Color.fromARGB(255, 12, 12, 12);
Color whiteColor = Colors.white;
Color scaffoldWhiteColor = Color.fromARGB(255, 240, 240, 240);
Color orangeColor = Colors.orange;
Color inputLightColor = Color.fromARGB(35, 0, 0, 0);
Color inputDarkColor = Color.fromARGB(35, 255, 255, 255);
Color iconDarkColor = Color.fromARGB(255, 125, 125, 125);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthRepository()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = prefs.getBool("darkMode")!;
      isSwitched = prefs.getBool("isSwitched")!;
      isAdmin = prefs.getBool("isAdmin")!;
      setGrid = prefs.getBool("setGrid")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MyRoutes.welcomeRoute: (context) => WelcomeScreen(),
        MyRoutes.loginRoute: (context) => LoginScreen(),
        MyRoutes.registerRoute: (context) => RegisterScreen(),
        MyRoutes.forgetRoute: (context) => ForgetScreen(),
        MyRoutes.helpRoute: (context) => HelpScreen(),
        MyRoutes.supportRoute: (context) => SupportScreen(),
        UserRoutes.userDashboard: (context) => UserDashboard(),
        RecruiterRoutes.recruiterDashboard: (context) => RecruiterDashboard(),
        AdminRoutes.adminDashboard: (context) => AdminDashboard(),
      },
    );
  }
}
