import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/auth%20svc/helper.dart';
import 'package:sahayak/auth%20ui/welcome_ui.dart';
import 'package:sahayak/constants.dart';
import 'package:sahayak/firebase_options.dart';
import 'package:sahayak/user/home.dart';

//import 'package:sahayak/user/SearchWorkers.dart';

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
    ));
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  void getUserLoggedInStatus() async {
    await helperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      } else {}
    });
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
        home: WelcomePage());
  }
}
