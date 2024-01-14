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
        apiKey: constants.apiKey,
        appId: constants.appId,
        messagingSenderId: constants.messagingSenderId,
        projectId: constants.projectId,
        storageBucket: "saahayak-77fed.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(MyApp());
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
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    getUserLoggedInStatus();
    await gettingUserData();
    await checkUserType();
    setState(() {}); // Rebuild the widget after initialization
  }

  gettingUserData() async {
    email = await helperFunctions.getUserEmailFromSF() ?? "";
    userName = await helperFunctions.getUserNameFromSF() ?? "";
  }

  void getUserLoggedInStatus() async {
    final value = await helperFunctions.getUserLoggedInStatus();
    if (value != null) {
      setState(() {
        _isSignedIn = value;
      });
    }
  }

  Future<void> checkUserType() async {
    if (_isSignedIn) {
      var collection = FirebaseFirestore.instance.collection('users');
      var querySnapshot =
          await collection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs.first;
        var data = documentSnapshot.data();
        userType = data?["userType"] ?? "";
        print('User Type: $userType');
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
              ? Home()
              : WorkerHome()
          : WelcomePage(),
    );
  }
}
