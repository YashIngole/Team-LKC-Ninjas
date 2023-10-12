import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';
import 'package:sahayak/auth%20ui/welcome_ui.dart';
import 'package:sahayak/user/Landingpage.dart';
import 'package:sahayak/user/notification.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const notification()),
                    );
                  },
                  icon: Icon(
                    Icons.send_outlined,
                    size: 50,
                  )),
            ],
          ),
          // const Spacer(),
          const SizedBox(
            height: 100,
          ),
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
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
            ],
          ),
          const Spacer(),
        ],
      ),
    ));
  }
}
