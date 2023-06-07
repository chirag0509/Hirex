import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mca_app_1/Repository/Database/userModel.dart';
import 'package:mca_app_1/Repository/Database/userRepository.dart';
import 'package:mca_app_1/main.dart';
import 'package:mca_app_1/pdfViewerPage.dart';

class UserDocuments extends StatefulWidget {
  @override
  State<UserDocuments> createState() => _UserDocumentsState();
}

class _UserDocumentsState extends State<UserDocuments> {
  final controller = Get.put(UserRepository());

  String fileUrl = "";
  FilePickerResult? file;
  void pickFile() async {
    file = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirFiles = referenceRoot.child("userFiles");
    Reference referenceFilesToUpload = referenceDirFiles.child(uniqueFileName);

    if (fileUrl.isNotEmpty) {
      try {
        await FirebaseStorage.instance.refFromURL(fileUrl).delete();
      } catch (err) {
        print("Failed to delete previous file: $err");
      }
    }

    try {
      await referenceFilesToUpload
          .putFile(File(file!.files.single.path.toString()));
      fileUrl = await referenceFilesToUpload.getDownloadURL();
    } catch (err) {
      print("Failed to upload file: $err");
    }
  }

  final fileName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size.height;
    final mqw = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
        child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: mqw * 0.04),
      child: Column(
        children: [
          StreamBuilder(
              stream: controller.getUserDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  return Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1.5,
                                  color: darkMode ? whiteColor : blackColor)),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              pickFile();
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    EdgeInsets.symmetric(vertical: mq * 0.05),
                                elevation: 0,
                                backgroundColor:
                                    darkMode ? inputDarkColor : inputLightColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: file == null
                                ? Icon(
                                    Icons.add,
                                    size: mqw * 0.15,
                                    color: darkMode ? whiteColor : blackColor,
                                  )
                                : Container(
                                    height: mq * 0.5,
                                    width: mqw * 1,
                                    child: PDFView(
                                      filePath: file!.files.single.path,
                                    ),
                                  ),
                          )),
                      SizedBox(height: mq * 0.015),
                      TextFormField(
                        controller: fileName,
                        style: TextStyle(
                            color: darkMode ? whiteColor : blackColor),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: orangeColor, width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          fillColor:
                              darkMode ? inputDarkColor : inputLightColor,
                          filled: true,
                          hintText: "Document name",
                          hintStyle: TextStyle(
                              color: darkMode ? whiteColor : blackColor),
                        ),
                      ),
                      SizedBox(height: mq * 0.015),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (file == null) {
                                Get.snackbar(
                                    "Error", "Please select a document",
                                    duration: Duration(seconds: 2));
                              } else if (fileName.text.trim() == "") {
                                Get.snackbar("Error", "Please enter file name",
                                    duration: Duration(seconds: 2));
                              } else {
                                final userNewData = UserModel(
                                    id: user.id,
                                    name: user.name,
                                    email: user.email,
                                    password: user.password,
                                    image: user.image,
                                    phone: user.phone,
                                    qualification: user.qualification,
                                    address: user.address,
                                    experience: user.experience,
                                    expertise: user.expertise,
                                    verified: user.verified,
                                    block: user.block,
                                    documents: fileUrl == ""
                                        ? user.documents
                                        : (user.documents ?? []) +
                                            [
                                              {
                                                "name": fileName.text.trim(),
                                                "url": fileUrl
                                              }
                                            ]);
                                controller.updateUserRecord(userNewData).then(
                                    (_) => Get.snackbar("Success",
                                        "File Uploaded Successfully"));
                                setState(() {
                                  file = null;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    darkMode ? orangeColor : blackColor,
                                padding:
                                    EdgeInsets.symmetric(vertical: mq * 0.018),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: darkMode ? blackColor : whiteColor),
                            )),
                      ),
                      SizedBox(height: mq * 0.015),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.6,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.documents!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  File file = await PDFApi.loadNetwork(
                                      snapshot.data!.documents![index]["url"]);
                                  Get.to(() => PDFViewerPage(
                                      file: file,
                                      name: snapshot.data!.documents![index]
                                          ["name"]));
                                },
                                child: Image.asset(
                                  "assets/images/PDF_image.png",
                                  width: mqw * 0.25,
                                ),
                              ),
                              Text(
                                snapshot.data!.documents![index]["name"]
                                    .toString()
                                    .capitalize
                                    .toString(),
                                style: TextStyle(
                                    fontSize: mqw * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: darkMode ? whiteColor : blackColor),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    final FirebaseStorage storage =
                                        FirebaseStorage.instance;
                                    final String url =
                                        snapshot.data!.documents![index]["url"];
                                    final Reference ref =
                                        storage.refFromURL(url);
                                    final String fileName = ref.name;
                                    final Reference userFileRef = storage
                                        .ref()
                                        .child('userFiles/$fileName');
                                    await userFileRef.delete();
                                    final userNewData = UserModel(
                                        id: user.id,
                                        name: user.name,
                                        email: user.email,
                                        password: user.password,
                                        image: user.image,
                                        phone: user.phone,
                                        verified: user.verified,
                                        qualification: user.qualification,
                                        address: user.address,
                                        experience: user.experience,
                                        block: user.block,
                                        expertise: user.expertise,
                                        documents: (user.documents ?? [])
                                            .where((doc) =>
                                                doc["name"] !=
                                                snapshot.data!.documents![index]
                                                    ["name"])
                                            .where((doc) =>
                                                doc["url"] !=
                                                snapshot.data!.documents![index]
                                                    ["url"])
                                            .toList());
                                    controller
                                        .updateUserRecord(userNewData)
                                        .then((_) => Get.snackbar("Success",
                                            "File Deleted Successfully"));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: Text("Delete"))
                            ],
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    ));
  }
}
