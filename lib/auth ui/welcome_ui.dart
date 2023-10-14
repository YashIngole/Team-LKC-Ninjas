// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sahayak/Themeconst.dart';

import 'package:sahayak/auth%20ui/register_ui.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kbackgroundcolor,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                child: Text(
                  "Your One-stop solution for local services",
                  style: GoogleFonts.acme(color: Colors.white, fontSize: 40),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: Image.asset(
                  'assets/sahayak.png',
                  //fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Spacer(),
              Text("Choose your login type: ",
                  style: GoogleFonts.acme(color: Colors.grey, fontSize: 20)),
              Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).push(_createRoute());
                      Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Registerpagee(userType: 'User')),
                                                  );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        // Set the border radius as needed
                      ),
                      elevation: 5, // Set the elevation (adjust as needed)
                      shadowColor: Color.fromARGB(127, 38, 45, 65),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/pana.png', // Replace with your image path
                          width: 120, // Set the width of the image
                          height: 120, // Set the height of the image
                        ),
                        Text(
                          "User",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ), // Set the text color to black
                        ),
                      ],
                    ),
                  )),

                  //Spacer(),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Registerpagee(userType: 'Worker')),
                                                  );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // Set the border radius as needed
                        ),
                      ),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/rafiki.png', // Replace with your image path
                            width: 120, // Set the width of the image
                            height: 120, // Set the height of the image
                          ),
                          Text(
                            "Worker",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                            // Set the text color to black
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              Spacer(),
            ],
          )),
    );
  }
}
