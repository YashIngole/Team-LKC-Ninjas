import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';
import 'package:sahayak/auth%20ui/welcome_ui.dart';
import 'package:sahayak/user/Landingpage.dart';

//import 'package:image_picker/image_picker.dart';
class userprofile extends StatefulWidget {
  const userprofile({super.key});

  @override
  State<userprofile> createState() => _HomeState();
}

User? currentUser = FirebaseAuth.instance.currentUser;
String userId = currentUser!.uid;
String issue = "";

class _HomeState extends State<userprofile> {
  final databaseService _databaseservice = databaseService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return SafeArea(
        child: Scaffold(
      backgroundColor: kbackgroundcolor,
      body: Column(
        children: [
          const Spacer(),
          const Text(
            "User Card",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: Get.height * 0.3,
            width: Get.width * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[800]),
          ),

          //Spacer(),
          // Center(
          //   child: SingleChildScrollView(
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 25),
          //       child: Container(
          //         height: Get.height * 0.05,
          //         width: Get.width * 0.6,
          //         color: ktilecolor,
          //         child: ElevatedButton(
          //             onPressed: () {
          //               Get.defaultDialog(
          //                   title: "Contact",
          //                   content: const SingleChildScrollView(
          //                     child: Column(
          //                       children: [
          //                         Text("Name: Mahesh doll"),
          //                         Text("Phone: 9131253231"),
          //                         Text("Locality: Civil lines")
          //                       ],
          //                     ),
          //                   ),
          //                   actions: [
          //                     ElevatedButton(
          //                         onPressed: () {},
          //                         child: const Text("send request")),
          //                   ]);
          //             },
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: Colors.transparent,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(0), // <-- Radius
          //               ),
          //             ),
          //             child: const Text(
          //               "Contact",
          //               style: TextStyle(fontSize: 20),
          //             )),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          Column(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.6,
                      color: ktilecolor,
                      // child: Text(
                      //   "Name : ",
                      //   style: TextStyle(
                      //     fontSize: 30,
                      //     backgroundColor: Colors.transparent,

                      //   ),
                      // ),
                      // child: ElevatedButton(
                      //   onPressed: () {
                      //     Get.defaultDialog(
                      //         title: "Send work request",
                      //         content: Column(
                      //           children: [
                      //             TextFormField(
                      //               onChanged: (val) {
                      //                 setState(() {
                      //                   issue = val;
                      //                 });
                      //               },
                      //               minLines: 5,
                      //               maxLines: null,
                      //               maxLength: 500,
                      //               decoration: const InputDecoration(
                      //                   border: OutlineInputBorder(),
                      //                   labelText: "Describe your issue"),
                      //             ),
                      //           ],
                      //         ),
                      //         actions: [
                      //           ElevatedButton(
                      //               onPressed: () {},
                      //               child: const Text("send request"))
                      //         ]);
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.transparent,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius:
                      //           BorderRadius.circular(0), // <-- Radius
                      //     ),
                      //   ),
                      //   child: const Text(
                      //     "Send requests",
                      //     style: TextStyle(fontSize: 20),
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              ElevatedButton(
                onPressed: () {
                  signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // <-- Radius
                  ),
                ),
                child: const Text(
                  "LogOut",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    ));
  }

  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }
}
