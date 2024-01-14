import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as loc; // Use 'loc' as the prefix
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/authentication.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';
import 'package:sahayak/auth%20svc/helper.dart';
import 'package:sahayak/auth%20ui/welcome_ui.dart';
import 'package:sahayak/user/SearchWorkers.dart';
import 'package:sahayak/user/customslider.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);
  final controller = CarouselController();

  @override
  State<LandingPage> createState() => _LandingPageState();
}

var selectedPage;
late PageController _myPage;

class _LandingPageState extends State<LandingPage> {
  late bool _serviceEnabled;
  late loc.PermissionStatus _permissionGranted;
  String locality = '';
  String country = '';
  String sublocality = '';

  // Use the prefix here
  AuthService authService = AuthService();
  loc.LocationData? _userLocation; // Use the prefix here

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

  @override
  void initState() {
    super.initState();

    _myPage = PageController(initialPage: 0);
    selectedPage = 0;
    gettingUserData();
    gettinglocationData();
  }

  String userName = "";
  String email = "";
  String CurrentCountry = "";
  String Currentlocality = "";
  String CurrentSublocality = "";
  String CurrentLatitude = "";
  String CurrentLongitude = "";

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
        CurrentLatitude = value!.toString();
      });
    });

    await helperFunctions.getLongitude().then((value) {
      setState(() {
        CurrentLongitude = value!.toString();
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

  final databaseService _databaseservice = databaseService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: PageView(
        controller: _myPage,
        children: [
          Column(
            children: [
              const Spacer(),
              Container(
                height: 70,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _getUserLocation().then((_) {
                                  getUserLocation();
                                });
                              },
                              icon: const Icon(Icons.location_on),
                              color: Colors.white,
                            ),
                            Text(
                              ' $CurrentSublocality, $Currentlocality',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        const Spacer(),
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
                                userName.toUpperCase(),
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color:
                                      const Color.fromARGB(255, 200, 201, 202),
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
                            Get.snackbar(
                              "Sign Out",
                              "You have been signed out.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 3),
                            );
                            Get.off(WelcomePage());
                          },
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xffa3a1e6),
                        Color(0xffd9b9b4),
                      ],
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset("assets/sahayak.png"),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Categories:",
                      style: GoogleFonts.andadaPro(
                          color: Colors.grey, fontSize: 20),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(const SearchWorkers(InitialVal: ""));
                      },
                      child: Text("View all",
                          style: GoogleFonts.andadaPro(
                              color: Colors.grey, fontSize: 15)),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: CustomCarouselSlider(controller: widget.controller)
                      .animate()),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
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
      await helperFunctions.saveCountry(country);
      await helperFunctions.saveLocality(locality);
      await helperFunctions.saveSubLocality(sublocality);
      await helperFunctions.saveLatitude(_userLocation!.latitude!.toDouble());
      await helperFunctions.saveLongitude(_userLocation!.longitude!.toDouble());
    }
  }

  // Function to sign out
}
