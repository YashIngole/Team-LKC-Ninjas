import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc; // Use 'loc' as the prefix
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
  late bool _serviceEnabled;
  late loc.PermissionStatus _permissionGranted;
  String locality = '';
  String country = '';
  String sublocality = '';

  // Use the prefix here
  AuthService authService = AuthService();
  loc.LocationData? _userLocation; // Use the prefix here
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
    _getUserLocation().then((_) {
      getUserLocation();
    });
  }

  final databaseService _databaseservice = databaseService();

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
              backgroundColor: ktilecolor,
              contentPadding: EdgeInsets.zero,
              title: "Create a Work",
              titleStyle: const TextStyle(color: Colors.white70),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: Get.width * 0.6,
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                title = val;
                              });
                            },
                            style: const TextStyle(color: Colors.white70),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 243, 65, 65),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 5),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'Name',
                                labelStyle:
                                    const TextStyle(color: Colors.white70)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Name';
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonFormField(
                            hint: const Text(
                              'Profession',
                              style: TextStyle(color: Colors.white),
                            ),
                            isExpanded: true,
                            dropdownColor: const Color(0xff212121),

                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: const TextStyle(color: Colors.white70),
                                ),
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
                          padding:
                              const EdgeInsets.only(left: 1, right: 1, top: 30),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white70),
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
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 243, 65, 65),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 5),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: 'Description',
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            User? user = authService.firebaseAuth.currentUser;

                            _databaseservice.saveworkerlisting(userName, title,
                                user!.uid, category, Description, [
                              _userLocation!.latitude,
                              _userLocation!.longitude,
                              locality,
                              sublocality,
                              country
                            ]);

                            Get.back(); // Close the dialog
                            // Show a Snackbar
                            Get.snackbar(
                                "Success", // Title of the Snackbar
                                "Listing created successfully", // Message of the Snackbar
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(
                                    0xff293241), // Background color (black)
                                colorText: Colors.white,
                                duration: const Duration(
                                    seconds: 1) // Text color (white)
                                );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors
                                    .white), // Set the background color to black
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Set the border radius to make it rectangular
                              ),
                            ),
                          ),
                          child: const Text("Create"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: kbackgroundcolor,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
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
                        style: GoogleFonts.roboto(
                          fontSize: 35,
                          color: const Color.fromARGB(255, 200, 201, 202),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      authService.signOut();
                      Get.snackbar("Sign Out", "You have been signed out.",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3));
                      Get.off(WelcomePage());
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    )),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Create a Work Listing here: ",
              style: TextStyle(color: Colors.grey),
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Worker deleted'),
                                      duration: Duration(seconds: 1),
                                      backgroundColor: Colors
                                          .black, // Adjust the duration as needed
                                    ),
                                  );
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
    Get.snackbar(
      "Sign Out",
      "You have been signed out.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const WelcomePage()));
  }

  Future<void> _getUserLocation() async {
    loc.Location location = loc.Location(); // Use the prefix here

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      // Use the prefix here
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        // Use the prefix here
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      _userLocation = locationData;
    });
  }

  // Function to get user location details
  getUserLocation() async {
    if (_userLocation != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _userLocation!.latitude!, _userLocation!.longitude!);
      Placemark place = placemarks[0];

      setState(() {
        locality = place.locality ?? 'Unknown';
        country = place.country ?? 'Unknown';
        sublocality = place.subLocality ?? 'Unknown';
      });

      // Displaying the location details in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Locality: $locality, Country: $country , Sublocality: $sublocality',
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      print(
          'Coordinates: ${_userLocation!.latitude}, ${_userLocation!.longitude}');
      print(place);
    }
  }
}
