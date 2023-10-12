import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/authentication.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';
import 'package:sahayak/auth%20svc/helper.dart';
import 'package:sahayak/user/UserProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

//import 'package:image_picker/image_picker.dart';
class workerprofile extends StatefulWidget {
  const workerprofile(
      {super.key,
      required this.workername,
      required this.ImageUrl,
      required this.userId});
  final String workername;
  final String ImageUrl;
  final String userId;
  @override
  State<workerprofile> createState() => _HomeState();
}

String userName = "";
String email = "";




String issue = "";
AuthService authService = AuthService();


class _HomeState extends State<workerprofile> {
  gettingUserData() async {
    await helperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await helperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    gettingUserData();
  }

  final databaseService _databaseservice = databaseService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kbackgroundcolor,
      body: Column(
        children: [
          const Spacer(),
          const Text(
            "Sahayak Card",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: Get.height * 0.3,
            width: Get.width * 0.6,
            // child: InkWell(
            //     borderRadius: BorderRadius.circular(1000),
            //     onTap: () async {
            //       ImagePicker imagePicker = ImagePicker();
            //       XFile? file = await imagePicker.pickImage(
            //         source: ImageSource.gallery,
            //       );
            //       if (file == null) {
            //         return;
            //       }
            //       //convert file to data
            //       final Uint8List fileBytes = await file.readAsBytes();

            //       // Reference to storage root of Firebase Storage
            //       Reference referenceRoot = FirebaseStorage.instance.ref();
            //       Reference referenceDirImages = referenceRoot.child('images');

            //       // Reference for the image to be stored
            //       String uniqueFileName =
            //           DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
            //       Reference referenceImageToUpload =
            //           referenceDirImages.child(uniqueFileName);
            //       try {
            //         // Store the file
            //         await referenceImageToUpload.putData(
            //             fileBytes, SettableMetadata(contentType: 'image/jpeg'));
            //         ImageUrl = await referenceImageToUpload.getDownloadURL();
            //         print(ImageUrl);
            //         setState(
            //           () {
            //             ImageUrl;
            //           },
            //         );
            //       } catch (e) {
            //         print('Error uploading image: $e');
            //       }
            //     },
            //     child: ImageUrl.isEmpty
            //         ? Container(
            //             height: 150,
            //             width: 150,
            //             decoration: BoxDecoration(
            //               color: kImgColor,
            //               borderRadius: BorderRadius.circular(1000),
            //             ),
            //             child: Center(
            //               child: Icon(
            //                 Icons.add_a_photo,
            //                 color: Colors.white,
            //                 size: 50,
            //               ),
            //             ),
            //           )
            //         : ImageNetwork(
            //             borderRadius: BorderRadius.circular(1000),
            //             image: ImageUrl,
            //             height: 150,
            //             width: 150)),
          ),

          //Spacer(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Container(
                  height: Get.height * 0.05,
                  width: Get.width * 0.6,
                  color: ktilecolor,
                  child: ElevatedButton(
                      onPressed: () {
                        User? userName = authService.firebaseAuth.currentUser;
                        Get.defaultDialog(
                            title: "Contact",
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text("user: ${userName?.displayName}"),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("send request")),
                            ]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // <-- Radius
                        ),
                      ),
                      child: const Text(
                        "Contact",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: Get.height * 0.05,
                  width: Get.width * 0.6,
                  color: ktilecolor,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.defaultDialog(
                            title: "Send work request",
                            content: Column(
                              children: [
                                TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      issue = val;
                                    });
                                  },
                                  minLines: 5,
                                  maxLines: null,
                                  maxLength: 500,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Describe your issue"),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    _databaseservice.createServiceRequest(
                                        issue, widget.userId);
                                  },
                                  child: const Text("send request"))
                            ]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // <-- Radius
                        ),
                      ),
                      child: const Text(
                        "Send requests",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    ));
  }
}
