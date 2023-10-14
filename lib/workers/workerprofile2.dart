import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/authentication.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';
import 'package:sahayak/auth%20svc/helper.dart';

//import 'package:image_picker/image_picker.dart';
class workerprofile2 extends StatefulWidget {
  const workerprofile2(
      {super.key, required this.DisplayName, required this.userId});
  final String DisplayName;
  final String userId;
  @override
  State<workerprofile2> createState() => _HomeState();
}

User? currentUser = FirebaseAuth.instance.currentUser;
String userId = currentUser!.uid;
String issue = "";
String ImageUrl = "";
String Phone = "";

class _HomeState extends State<workerprofile2> {
  String userName = "";
  String email = "";

  Future<void> getUserData() async {
    email = await helperFunctions.getUserEmailFromSF() ?? '';
    userName = await helperFunctions.getUserNameFromSF() ?? '';
    final imageUrl = await getImageUrl(userId);
    final phone = await getPhoneNumber(userId);

    setState(() {
      ImageUrl = imageUrl ?? "";
      Phone = phone ?? "";
    });
  }

  AuthService authService = AuthService();
  final databaseService _databaseservice = databaseService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    getUserData();
    getImageUrl(userId);
    getPhoneNumber(userId);
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    final currentuid = user!.uid;
    print(currentuid);

    return SafeArea(
      child: Scaffold(
        backgroundColor: kbackgroundcolor,
        appBar: AppBar(
          backgroundColor: kbackgroundcolor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ), // Replace "your_custom_icon" with the icon you want to use
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(children: [
          const Spacer(),
          Text(
            "Sahayak Card",
            style: GoogleFonts.roboto(
              fontSize: 35,
              color: const Color.fromARGB(255, 200, 201, 202),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          CachedNetworkImage(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.6,
            imageUrl: ImageUrl,
            imageBuilder: (context, imageProvider) => Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  color: ktilecolor, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name : ${widget.DisplayName}",
                          style: GoogleFonts.acme(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Send work request"),
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
                                labelText: "Describe your issue",
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              _databaseservice.createServiceRequest(
                                  issue, widget.userId, false, currentuid);
                              Navigator.pop(context);
                              const snackBar = SnackBar(
                                content: Text(
                                    "Request Sent\nYour work request has been sent."),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Text("send request"),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // <-- Radius
                  ),
                ),
                child: const Text(
                  "Send Work request",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          const Spacer()
        ]),
      ),
    );
  }

  Future<String?> getImageUrl(String userId) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users') // Replace with your collection name
          .where('uid', isEqualTo: userId)
          .limit(1) // Limit to one document (in case multiple matches)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final imageUrl = snapshot.docs.first['ImageUrl'];
        return imageUrl;
      } else {
        // No document matching the condition was found.
        return null;
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return null;
    }
  }

  Future<String?> getPhoneNumber(String userId) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users') // Replace with your collection name
          .where('uid', isEqualTo: userId)
          .limit(1) // Limit to one document (in case multiple matches)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final phone = snapshot.docs.first['Phone'];
        return phone;
      } else {
        // No document matching the condition was found.
        return null;
      }
    } catch (e) {
      print('Error fetching Phone: $e');
      return null;
    }
  }

  void AddImageUrl() async {
    var collection = FirebaseFirestore.instance.collection('users');

    var querySnapshot = await collection.where('uid', isEqualTo: userId).get();
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      collection
          .doc(documentSnapshot.id)
          .update({'ImageUrl': ImageUrl})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    }
  }

  void AddPhoneNumber() async {
    var collection = FirebaseFirestore.instance.collection('users');

    var querySnapshot = await collection.where('uid', isEqualTo: userId).get();
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      collection
          .doc(documentSnapshot.id)
          .update({'Phone': Phone})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    }
  }
}
