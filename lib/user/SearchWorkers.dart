import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sahayak/Loading.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/helper.dart';
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
  String? selectedCategory;
  String userName = "";
  String email = "";
  String CurrentCountry = "";
  String Currentlocality = "";
  String CurrentSublocality = "";
  double CurrentLatitude = 1;
  double CurrentLongitude = 1;

  @override
  void initState() {
    super.initState();
    controller.text = widget.InitialVal;
    searchQuery = widget.InitialVal.toLowerCase();
    gettingUserData();
    gettinglocationData();
  }

  gettinglocationData() async {
    await helperFunctions.getCountry().then((value) {
      setState(() {
        CurrentCountry = value!;
      });
    });
    await helperFunctions.getSubLocality().then((value) {
      setState(() {
        CurrentSublocality = value!;
      });
    });
    await helperFunctions.getLocality().then((value) {
      setState(() {
        Currentlocality = value!;
      });
    });
    await helperFunctions.getLatitude().then((value) {
      setState(() {
        CurrentLatitude = value!;
      });
    });

    await helperFunctions.getLongitude().then((value) {
      setState(() {
        CurrentLongitude = value!;
      });
    });
  }

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
      backgroundColor: kbackgroundcolor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Search For Workers Nearby You!",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 20),
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
                        String DiplayName = data['DisplayName'] ?? "";
                        final locationArray =
                            data['location'] as List<dynamic>?;

                        double distanceInKm = 0;
                        if (locationArray != null &&
                            locationArray.length >= 2) {
                          double workerLatitude = locationArray[0];
                          double workerLongitude = locationArray[1];
                          distanceInKm = Geolocator.distanceBetween(
                                CurrentLatitude,
                                CurrentLongitude,
                                workerLatitude,
                                workerLongitude,
                              ) /
                              1000;
                        }

                        String formattedDistance =
                            'Distance: ${distanceInKm.toStringAsFixed(2)} km';

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              Get.to(workerprofile2(
                                DisplayName: DiplayName,
                                userId: userId,
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ktilecolor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 1.0, color: Colors.white24)),
                                  ),
                                  child: const Icon(Icons.work,
                                      color: Colors.white),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      data['DisplayName'] + "-",
                                      style: TextStyle(color: Colors.white),
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
                                    Text(formattedDistance,
                                        style: TextStyle(color: Colors.white)),
                                    Text('Latitude: ${locationArray![0]}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    Text('Longitude: ${locationArray[1]}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    Text('Locality: ${locationArray[2]}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    Text('Sublocality: ${locationArray[3]}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    Text('Country: ${locationArray[4]}',
                                        style: const TextStyle(
                                            color: Colors.white)),
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
