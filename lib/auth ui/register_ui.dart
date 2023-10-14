import 'dart:ui';
import 'package:sahayak/Loading.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/auth ui/login.dart';
import 'package:flutter/material.dart';

import 'package:sahayak/auth svc/authentication.dart';
import 'package:sahayak/auth svc/helper.dart';

class Registerpagee extends StatefulWidget {
  const Registerpagee({Key? key, required this.userType}) : super(key: key);
  final String userType;
  @override
  State<Registerpagee> createState() => _LoginPageState();
}

class _LoginPageState extends State<Registerpagee> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final _workerFormKey = GlobalKey<FormState>();

  final double _sigmaX = 5;
  // from 0-10
  final double _sigmaY = 5;
  // from 0-10
  final double _opacity = 0.2;

  String email = "";
  String password = "";
  String fullname = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  bool _passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: _isLoading
          ? const Center(
              child: LoadingIndicator(),
            )
          : Form(
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
                  SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: _sigmaX, sigmaY: _sigmaY),
                              child: Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(0, 0, 0, 1)
                                          .withOpacity(_opacity),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.77,
                                  child: Form(
                                    key: widget.userType == "Worker"
                                        ? _workerFormKey
                                        : _formKey,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          const Text(
                                              "Look like you don't have an account. Let's create a new account",
                                              // ignore: prefer_const_constructors
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                              textAlign: TextAlign.start),
                                          // ignore: prefer_const_constructors
                                          SizedBox(height: 20),

                                          TextFormField(
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.white),
                                                        ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color:
                                                        //         Colors.grey.shade400),
                                                        ),
                                                fillColor: kfieldcolor,
                                                filled: true,
                                                hintText: "Fullname",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[500])),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            //parameter for name input
                                            onChanged: (val) {
                                              setState(() {
                                                fullname = val;
                                                print(fullname);
                                              });
                                            },
                                            validator: (val) {
                                              if (val!.isNotEmpty) {
                                                return null;
                                              } else {
                                                return "Name cannot be empty";
                                              }
                                            },
                                          ),

                                          const SizedBox(height: 20),

                                          TextFormField(
                                            //parameter for Email input

                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.white),
                                                        ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color:
                                                        //         Colors.grey.shade400),
                                                        ),
                                                fillColor: kfieldcolor,
                                                filled: true,
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[500])),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return 'Please enter an email address';
                                              } else if (!RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(val)) {
                                                return 'Please enter a valid email';
                                              }
                                              return null;
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
                                                    const OutlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.white),
                                                        ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color:
                                                        //         Colors.grey.shade400),
                                                        ),
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
                                          const SizedBox(height: 30),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  widget.userType == "Worker"
                                                      ? registerworker()
                                                      : registeruser();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0)),
                                                  fixedSize:
                                                      const Size(350, 50),
                                                  backgroundColor: ktilecolor,
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                child: const Text(
                                                  'Register',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                  'Already have an Account?',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginPage(
                                                                userType: widget
                                                                    .userType)),
                                                  );
                                                },
                                                child: const Text(
                                                  ' Sign In.',
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  registerworker() async {
    if (_workerFormKey.currentState!.validate()) {
      // Use _workerFormKey here
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerworkerWithEmailAndPassword(
              fullname, email, password, widget.userType)
          .then((value) async {
        if (value == true) {
          await helperFunctions.saveUserLoggedInStatus(true);
          await helperFunctions.saveUserEmailSF(email);
          await helperFunctions.saveUsernameSF(fullname);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(userType: widget.userType)),
          );
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  registeruser() async {
    if (_formKey.currentState!.validate()) {
      // Use _formKey here
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailAndPassword(
              fullname, email, password, widget.userType)
          .then((value) async {
        if (value == true) {
          await helperFunctions.saveUserLoggedInStatus(true);
          await helperFunctions.saveUserEmailSF(email);
          await helperFunctions.saveUsernameSF(fullname);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(userType: widget.userType)),
          );
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
