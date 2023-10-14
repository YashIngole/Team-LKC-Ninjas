import 'dart:ui';

import 'package:sahayak/Loading.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth%20svc/authentication.dart';
import 'package:sahayak/auth%20svc/databaseService.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahayak/user/home.dart';
import 'package:sahayak/auth%20ui/register_ui.dart';
import 'package:sahayak/auth svc/helper.dart';
import 'package:sahayak/workers/workerHome.dart';

double _sigmaX = 5;
// from 0-10
double _sigmaY = 5;
// from 0-10
double _opacity = 0.2;

String email = "";
String password = "";
String fullname = "";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.userType});
  final String userType;
  @override
  State<LoginPage> createState() => _SigninState();
}

class _SigninState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  bool _passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: LoadingIndicator(),
            )
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        transform: GradientRotation(43),
                        colors: [
                          Color(0xff25252E),
                          Color(0xff222433),
                        ],
                      )),
                    ),
                    SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold)),
                          // SizedBox(
                          //     height: MediaQuery.of(context).size.height * 0.05),
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: _sigmaX, sigmaY: _sigmaY),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 0, 0, 1)
                                        .withOpacity(_opacity),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30))),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Form(
                                  key: _loginFormKey,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 7),
                                          child: Text(
                                              "Welcome back! Sign in to your account to access all the great features and services",
                                              // ignore: prefer_const_constructors
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                              textAlign: TextAlign.start),
                                        ),
                                        // ignore: prefer_const_constructors
                                        SizedBox(height: 20),

                                        const SizedBox(height: 20),

                                        TextFormField(
                                          //parameter for Email input

                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(),
                                              fillColor: kfieldcolor,
                                              filled: true,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[500])),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          validator: (val) {
                                            return RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(val!)
                                                ? null
                                                : "Please enter a valid email";
                                          },
                                          onChanged: (val) {
                                            setState(() {
                                              email = val;
                                              print(email);
                                            });
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(),
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _passwordObscured =
                                                        !_passwordObscured;
                                                  });
                                                },
                                                icon: Icon(
                                                  _passwordObscured
                                                      ? Icons
                                                          .visibility_off_outlined
                                                      : Icons
                                                          .visibility_outlined,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              fillColor: kfieldcolor,
                                              filled: true,
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[500])),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          //parameter for name input
                                          onChanged: (val) {
                                            setState(() {
                                              password = val;
                                              print(password);
                                            });
                                          },
                                          obscureText: _passwordObscured,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Password is required';
                                            } else if (value.length < 6) {
                                              return 'Password must be at least 6 characters long';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const SizedBox(height: 15),
                                            ElevatedButton(
                                              onPressed: () {
                                                //Function for saving and validating email and password
                                                sign_in();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0)),
                                                fixedSize: const Size(350, 50),
                                                backgroundColor: ktilecolor,
                                                shadowColor: Colors.transparent,
                                              ),
                                              child: const Text(
                                                'Login',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 35),
                                              child: Center(
                                                child: Text(
                                                    "Don't have an Account?",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                //to register screen
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                " Create One",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 59, 179, 235)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    ); //form, Singlechildscrollview, Scaffold
  }

  sign_in() async {
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await authService.loginWithEmailAndPassword(email, password);
        QuerySnapshot snapshot =
            await databaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);

        // Saving the values to shared preferences
        await helperFunctions.saveUserLoggedInStatus(true);
        await helperFunctions.saveUserEmailSF(email);
        await helperFunctions.saveUsernameSF(snapshot.docs[0]['fullName']);

        // Check if the user is logged in
        bool? isLoggedIn = await helperFunctions.getUserLoggedInStatus();

        // Now, let's check the user's type and navigate accordingly
        String? useremail = authService.firebaseAuth.currentUser!.email;

        void checkUserType() async {
          var collection = FirebaseFirestore.instance.collection('users');

          var querySnapshot =
              await collection.where('email', isEqualTo: useremail).get();

          if (querySnapshot.docs.isNotEmpty) {
            var documentSnapshot = querySnapshot.docs.first;
            var data = documentSnapshot.data();

            if (data["userType"] == "user") {
              // Navigate to the user home screen
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Home()),
  );
            } else {
              // Navigate to the worker home screen
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const WorkerHome()),
  );
            }
          }
        }

        // Call the function to check user type
        checkUserType();
      } catch (error) {
        final snackBar = SnackBar(
        content: Text("Login Credentials mismatched. \nPlease try again"),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
