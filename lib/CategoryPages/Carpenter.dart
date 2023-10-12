import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahayak/Loading.dart';
import 'package:sahayak/Themeconst.dart';

class carpenter extends StatefulWidget {
  const carpenter({super.key});

  @override
  State<carpenter> createState() => _carpenterState();
}

class _carpenterState extends State<carpenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('service_requests')
            .where('userId', isEqualTo: "wIswYjPXfVc0YbBCo2k85jCS1I03")
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
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
                        child: const Icon(Icons.request_page, color: Colors.white),
                      ),
                      title: Text(
                        data['issue'],
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
                      trailing: ElevatedButton(
                          onPressed: () {}, child: const Text("Accept")),
                    ),
                  ),
                );

                // ListTile(
                //   title: Text(data['issue']),
                //   subtitle: Text(data['createdAt'].toString()),
                // );
              },
            );
          }

          return const Center(child: LoadingIndicator());
        },
      ),
    );
  }
}
