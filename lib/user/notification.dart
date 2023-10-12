import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahayak/Themeconst.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      //backgroundColor: kbackgroundcolor,
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
          future: firestore.collection('service_requests').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('No documents found');
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                var data = document.data() as Map<String, dynamic>;
                // You can access fields of the document here
                var date = data['createdAt'];
                var Issue = data['issue'];

                return ListTile(
                  title: Text('Title: $date'),
                  subtitle: Text('Issue: $Issue'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
