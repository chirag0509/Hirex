import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mca_app_1/main.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

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
          "Privacy",
          style: TextStyle(color: darkMode ? whiteColor : blackColor),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.03),
        child: Column(
          children: [
            Text(
              "Introduction",
              style: TextStyle(color: orangeColor, fontSize: w * 0.05),
            ),
            SizedBox(
              height: w * 0.015,
            ),
            Text(
              "We, at Info Edge (India) Limited and our affiliated companies worldwide (hereinafter collectively referred to as 'IEIL'), are committed to respecting your online privacy and recognize the need for appropriate protection and management of any personally identifiable information you share with us. This Privacy Policy ('Policy') describes how IEIL collects, uses, discloses and transfers personal information of users through its websites and applications, including through www.HireX.com, mobile applications and online services (collectively, the 'Platform'). This policy applies to those who visit the Platform, or whose information IEIL otherwise receives in connection with its services (such as contact information of individuals associated with IEIL including partners) (hereinafter collectively referred to as 'Users'). For the purposes of the Privacy Policy, 'You' or 'Your' shall mean the person who is accessing the Platform",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            SizedBox(
              height: w * 0.05,
            ),
            Text(
              "Types of Personal Information collected by IEIL",
              style: TextStyle(color: orangeColor, fontSize: w * 0.05),
            ),
            SizedBox(
              height: w * 0.015,
            ),
            Text(
              "'Personal information' (PI) - means any information relating to an identified or identifiable natural person including common identifiers such as a name, an identification number, location data, an online identifier or one or more factors specific to the physical, physiological, genetic, mental, economic, cultural or social identity of that natural person and any other information that is so categorized by applicable laws. We collect information about you and/or your usage to provide better services and offerings. The Personal Information that we collect, and how we collect it, depends upon how you interact with us. We collect the following categories of Personal Information in the following ways:",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "name, email address, password, country, city, contact number and company/organization that you are associated with, when the you sign up for alerts on the Platform;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "information that one would usually include in a resume, including name, contact details including e-mail address and mobile number, work experience, educational qualifications, data relating to your current and past remuneration or salary, a copy of your resume, etc. when you register on the Platform;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "information about the services that you use and how you use them, including log information and location information, when you are a user of the services through the Platform",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "we may collect your Personal Information such as name, age, contact details, preferences, etc. through surveys and forms, when you choose to participate in these surveys etc.",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "we may also collect information relating to your caste and information about whether you are eligible for any affirmative action programmes or policies, if you opt to provide such information",
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
              "How IEIL may use your Personal Information",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Providing our services and products to you including to send you job alerts, calendar alerts, relevant search results, recommended jobs and/or candidates (as the case maybe), and other social media communication facilities",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Protecting our Users and providing you with customer support;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "We use information collected from cookies and other technologies, to improve your user experience and the overall quality of our services (for more information please refer to paragraph 4 below). When showing you tailored ads, we will not associate an identifier from cookies or similar technologies with sensitive categories, such as those based on race, religion, sexual orientation or health.",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Improving the Platform and its content to provide better features and services;",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Conducting market research and surveys with the aim of improving our products and services",
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
            Text(
              "Sending you information about our products and services for marketing purposes and promotions;;",
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
