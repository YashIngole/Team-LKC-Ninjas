import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/Loading.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/authentication.dart';
import 'package:sahayak/user/UserProfile.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = AuthService().firebaseAuth.currentUser;
    String uid = user!.uid.toString();
    print(uid);
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text("Sent Requests", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), // Replace "your_custom_icon" with the icon you want to use
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('service_requests')
            .where('SenderId', isEqualTo: uid)
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Text('Error = ${snapshot.error}');
          }

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                String desc = data['issue'].toString();
                bool AcceptedStatus = data['AcceptedStatus'] ?? false;

                print(AcceptedStatus ?? "lol");
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                                      width: 1.0, color: Colors.white24))),
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
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        trailing: AcceptedStatus
                            ? Text("Status : Accepted")
                            : Text("Status : Rejected")),
                  ),
                );
              },
            );
          }

          return const Center(child: LoadingIndicator());
        },
      )),
    );
  }
}
