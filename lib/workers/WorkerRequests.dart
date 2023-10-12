import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahayak/Loading.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/authentication.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';
import 'package:sahayak/auth%20svc/helper.dart';

class workerrequests extends StatefulWidget {
  const workerrequests({Key? key});

  @override
  State<workerrequests> createState() => _workerrequestsState();
}

class _workerrequestsState extends State<workerrequests> {
  final TextEditingController availabilityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<String> descriptions = [];

  final databaseService _databaseservice = databaseService();
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

  AuthService authService = AuthService();

  @override
  void initState() {
    gettingUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = authService.firebaseAuth.currentUser;
    String workerId = user!.uid.toString();

    return SafeArea(
      child: Scaffold(
        backgroundColor: kbackgroundcolor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Work Requests',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('service_requests')
                    .where('userId', isEqualTo: workerId)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error = ${snapshot.error}');
                  }

                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    descriptions.clear();
                    return Expanded(
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (_, i) {
                          final data = docs[i].data();
                          String desc = data['issue'].toString();
                          descriptions.add(desc);
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
                                  child: const Icon(Icons.request_page,
                                      color: Colors.white),
                                ),
                                title: Text(
                                  desc,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['createdAt'].toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    if (data['AcceptStatus'] == 'false') {
                                      updateAcceptStatusTrue(i);
                                    } else {
                                      updateAcceptStatusFalse(i);
                                    }
                                  },
                                  child: data['AcceptStatus'] == 'false'
                                      ? const Text("Accept")
                                      : const Text("Accepted"),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return const Center(child: LoadingIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateAcceptStatusFalse(int index) async {
    String descToUpdate = descriptions[index];
    var collection = FirebaseFirestore.instance.collection('service_requests');

    var querySnapshot =
        await collection.where('issue', isEqualTo: descToUpdate).get();
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      collection
          .doc(documentSnapshot.id)
          .update({'AcceptStatus': "false"})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    }
  }

  void updateAcceptStatusTrue(int index) async {
    String descToUpdate = descriptions[index];
    var collection = FirebaseFirestore.instance.collection('service_requests');

    var querySnapshot =
        await collection.where('issue', isEqualTo: descToUpdate).get();
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      collection
          .doc(documentSnapshot.id)
          .update({'AcceptStatus': "true"})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    }
  }
}
