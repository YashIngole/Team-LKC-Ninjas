import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/Loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/authentication.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';
import 'package:sahayak/auth%20svc/helper.dart';
import 'package:sahayak/auth%20ui/welcome_ui.dart';

class workerpage extends StatefulWidget {
  const workerpage({Key? key});

  @override
  State<workerpage> createState() => _workerpageState();
}

class _workerpageState extends State<workerpage> {
  String userName = "";
  String email = "";
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
    super.initState();
    gettingUserData();
  }

  final databaseService _databaseservice = databaseService();
  AuthService authService = AuthService();
  String title = "";
  String title1 = "";
  String listId = "";
  String? category;
  String Description = "";
  List<String> categories = [];
  List<DocumentSnapshot<Map<String, dynamic>>> docs = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kbackgroundcolor,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 6),
                      child: Text(
                        'Hi...!',
                        style: GoogleFonts.adamina(
                            color: Kusercolor, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        userName,
                        style: const TextStyle(
                          color: Kusercolor,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      signOut();
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    )),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.defaultDialog(
                          contentPadding: EdgeInsets.zero,
                          barrierDismissible: false,
                          title: "Create a listing",
                          content: SingleChildScrollView(
                            child: SizedBox(
                              width: Get.width * 0.5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      onChanged: (val) {
                                        setState(() {
                                          title = val;
                                        });
                                      },
                                      style: const TextStyle(),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 243, 65, 65),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 0, 0, 5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        labelText: 'Title',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter title';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: DropdownButtonFormField(
                                      isExpanded: true,

                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),

                                      // Array list of items
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        // print('Selected category: $newValue');
                                        setState(() {
                                          category = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 20, vertical: 10),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 30),
                                    child: TextFormField(
                                      onChanged: (val) {
                                        setState(() {
                                          Description = val;
                                        });
                                      },
                                      minLines: 2,
                                      maxLines: null,
                                      maxLength: 500,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 243, 65, 65),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 0, 0, 5),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        labelText: 'Description',
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        User? user = authService
                                            .firebaseAuth.currentUser;

                                        _databaseservice.saveworkerlisting(
                                            userName,
                                            title,
                                            user!.uid,
                                            category,
                                            Description);
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all<Color>(Colors
                                                .black), // Set the background color to black
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                0.0), // Set the border radius to make it rectangular
                                          ),
                                        ),
                                      ),
                                      child: const Text("Create")),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.add)),
                ),
                const Text(
                  "Create a Listing",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('workerlisting')
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error = ${snapshot.error}');
                  }

                  if (snapshot.hasData) {
                    docs = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        title1 = data!["title"];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ktilecolor,
                                borderRadius: BorderRadius.circular(6)),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              leading: Container(
                                padding: const EdgeInsets.only(right: 12.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 1.0,
                                            color: Colors.white24))),
                                child:
                                    const Icon(Icons.work, color: Colors.white),
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      data['title'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['category'].toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(data['Description'],
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Divider(
                                      color: Colors.white,
                                      height: 10,
                                      thickness: 2),
                                  Text(
                                    "by \n" + data['DisplayName'],
                                    style: GoogleFonts.abhayaLibre(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.white, size: 30.0),
                                onPressed: () {
                                  deleteworklistData(i);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(child: LoadingIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteworklistData(int index) async {
    if (index >= 0 && index < docs.length) {
      var documentSnapshot = docs[index];
      var collection = FirebaseFirestore.instance.collection('workerlisting');

      collection
          .doc(documentSnapshot.id)
          .delete()
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    } else {
      print('Document not found');
    }
  }

  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const WelcomePage()));
  }
}
