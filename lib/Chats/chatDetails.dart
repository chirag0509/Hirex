import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mca_app_1/Repository/Authentication/authRepository.dart';
import 'package:mca_app_1/Repository/Database/chatModel.dart';
import 'package:mca_app_1/Repository/Database/chatRepository.dart';
import 'package:intl/intl.dart';
import 'package:mca_app_1/main.dart';

class ChatDetails extends StatefulWidget {
  final String sender;
  final String image;
  final String name;
  ChatDetails(
      {Key? key, required this.sender, required this.image, required this.name})
      : super(key: key);

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  final controller = Get.put(ChatRepository());
  final chat = TextEditingController();

  FocusNode _focusNode = FocusNode();

  Stream<List<ChatModel>> getSenderChatsStream() {
    return FirebaseFirestore.instance
        .collection("Chats")
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((e) => ChatModel.fromSnapshot(e))
            .where((user) =>
                (user.sender == widget.sender &&
                    user.receiver ==
                        AuthRepository.instance.firebaseUser.value!.email) ||
                (user.sender ==
                        AuthRepository.instance.firebaseUser.value!.email &&
                    user.receiver == widget.sender))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: darkMode ? whiteColor : blackColor),
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  isSwitched
                      ? recruiterPageController.jumpTo(1)
                      : userPageController.jumpTo(1);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: w * 0.065,
                )),
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(widget.image),
              radius: w * 0.055,
            ),
            SizedBox(
              width: w * 0.025,
            ),
            Text(
              widget.name.capitalize.toString(),
              style: TextStyle(color: darkMode ? whiteColor : blackColor),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: darkMode ? blackColor : scaffoldWhiteColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.88,
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.78,
                  child: StreamBuilder<List<ChatModel>>(
                      stream: getSenderChatsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final bool isMe =
                                    snapshot.data![index].sender ==
                                        AuthRepository
                                            .instance.firebaseUser.value!.email;
                                return Row(
                                  mainAxisAlignment:
                                      snapshot.data![index].sender ==
                                              AuthRepository.instance
                                                  .firebaseUser.value!.email
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: isMe
                                            ? orangeColor
                                            : darkMode
                                                ? inputDarkColor
                                                : whiteColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: !isMe
                                              ? Radius.circular(0)
                                              : Radius.circular(15),
                                          bottomRight: isMe
                                              ? Radius.circular(0)
                                              : Radius.circular(15),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: w * 0.6,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: isMe
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].chatData,
                                              style: TextStyle(
                                                  color: isMe
                                                      ? blackColor
                                                      : darkMode
                                                          ? whiteColor
                                                          : blackColor,
                                                  fontSize: w * 0.04),
                                              textAlign: isMe
                                                  ? TextAlign.end
                                                  : TextAlign.start,
                                            ),
                                            Text(
                                              DateFormat.Hm()
                                                  .format(snapshot
                                                      .data![index].time
                                                      .toDate())
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: isMe
                                                    ? blackColor
                                                    : darkMode
                                                        ? whiteColor
                                                        : blackColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.065,
                  width: w * 1,
                  color: darkMode ? inputDarkColor : whiteColor,
                  child: TextFormField(
                    controller: chat,
                    style: TextStyle(
                        color: darkMode ? whiteColor : blackColor,
                        fontSize: w * 0.04),
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: w * 0.04, horizontal: w * 0.07),
                      hintStyle: TextStyle(
                          color: darkMode ? whiteColor : blackColor,
                          fontSize: w * 0.04),
                      suffixIcon: Container(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.015),
                        child: IconButton(
                            onPressed: () async {
                              if (chat.text.trim() != "") {
                                final chats = ChatModel(
                                    sender: AuthRepository
                                        .instance.firebaseUser.value!.email
                                        .toString(),
                                    receiver: widget.sender,
                                    time: Timestamp.now(),
                                    chatData: chat.text.trim());
                                await controller.createChat(chats);
                                chat.clear();
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              size: w * 0.065,
                              color: darkMode ? whiteColor : blackColor,
                            )),
                      ),
                    ),
                    focusNode: _focusNode,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    ));
  }
}
