import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahayak/Loading.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/helper.dart';
import 'package:sahayak/workers/workerprofile.dart';
import 'package:sahayak/workers/workerprofile2.dart';

class SearchWorkers extends StatefulWidget {
  const SearchWorkers({Key? key, required this.InitialVal});
  final String InitialVal;
  @override
  State<SearchWorkers> createState() => _SearchWorkersState();
}

class _SearchWorkersState extends State<SearchWorkers> {
  TextEditingController controller = TextEditingController();
  String searchQuery = '';
  String? selectedCategory; // Added variable to store selected category
  @override
  void initState() {
    // TODO: implement initState
    controller.text = widget.InitialVal;
    searchQuery = widget.InitialVal.toLowerCase();
    gettingUserData();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Search Workers'),
      // ),
      backgroundColor: kbackgroundcolor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  fillColor: kfieldcolor,
                  filled: true,
                  hintText: 'Search Sahayak',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 185, 197, 207)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),

                  //enabled: false
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 220, top: 5, bottom: 10, right: 20),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration.collapsed(
                  fillColor: kfieldcolor,
                  filled: true,
                  hintText: '  Filter',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  enabled: false,
                ),
                dropdownColor: kfieldcolor,
                isExpanded: true,
                icon: const Icon(Icons.filter_alt_outlined),
                value: selectedCategory,
                items: items.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue ?? "";
                  });
                },
              ),
            ),
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
                    final docs = snapshot.data!.docs;

                    final filteredDocs = docs.where((doc) {
                      final data = doc.data();
                      final title = data['title'].toString().toLowerCase();
                      final category =
                          data['category'].toString().toLowerCase();
                      final description =
                          data['Description'].toString().toLowerCase();

                      // Apply both search query and category filter
                      return (title.contains(searchQuery) ||
                              category.contains(searchQuery) ||
                              description.contains(searchQuery)) &&
                          (selectedCategory == null ||
                              category == selectedCategory!.toLowerCase());
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredDocs.length,
                      itemBuilder: (_, i) {
                        final data = filteredDocs[i].data();
                        String userId = data['worker id'].toString();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              Get.to(workerprofile2());
                            },
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
                                  child: const Icon(Icons.work,
                                      color: Colors.white),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      data['DisplayName'] + "-",
                                      style: GoogleFonts.abhayaLibre(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      data['title'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['category'].toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(data['Description'],
                                        style: const TextStyle(
                                            color: Colors.white))
                                  ],
                                ),
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
}
