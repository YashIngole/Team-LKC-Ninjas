import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/auth%20svc/helper.dart';
import 'package:sahayak/auth%20ui/welcome_ui.dart';
import 'package:sahayak/constants.dart';
import 'package:sahayak/firebase_options.dart';
import 'package:sahayak/user/home.dart';
import 'package:sahayak/workers/workerHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: constansts.apiKey,
        appId: constansts.appId,
        messagingSenderId: constansts.messagingSenderId,
        projectId: constansts.projectId,
        storageBucket: "saahayak-77fed.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  String userName = "";
  String email = "";
  String userType = "";
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
    gettingUserData();
    checkUserType(); // Move this here to check user type on app start
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

  void getUserLoggedInStatus() async {
    await helperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  void checkUserType() async {
    if (_isSignedIn) {
      var collection = FirebaseFirestore.instance.collection('users');

      var querySnapshot =
          await collection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs.first;
        var data = documentSnapshot.data();

        // Example: printing userType
        userType = data["userType"];
        print('User Type: $userType');

        // Use the data retrieved for further processing or navigation
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sahayak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _isSignedIn
          ? userType == "user"
              ? const Home()
              : const WorkerHome()
          : const WelcomePage(),
    );
  }
}
