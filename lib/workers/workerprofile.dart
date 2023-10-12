import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';
import 'package:sahayak/user/UserProfile.dart';

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

String issue = "";

class _HomeState extends State<workerprofile> {
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[800]),
          ),
          //Spacer(),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  height: Get.height * 0.05,
                  width: Get.width * 0.6,
                  color: ktilecolor,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.defaultDialog(
                            title: "Contact",
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text("Name: ${widget.workername}"),
                                  const Text("Phone: 9131253231"),
                                  const Text("Locality: Civil lines")
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
