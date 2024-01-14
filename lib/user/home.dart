import 'package:flutter/material.dart';

import 'package:sahayak/Themeconst.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sahayak/user/Landingpage.dart';
import 'package:sahayak/user/SearchWorkers.dart';
import 'package:sahayak/user/UserProfile.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final List<Widget> _widgetOptions = <Widget>[
    LandingPage(),
    const SearchWorkers(
      InitialVal: "",
    ),
    const userprofile()
  ];
  //final CarouselController controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('drawer'),
        // ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        backgroundColor: kbackgroundcolor,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: const Color(0xff2f3033), boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ]),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: kbackgroundcolor,
                hoverColor: kbackgroundcolor,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.white,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                    iconColor: Colors.white,
                  ),
                  GButton(
                    icon: LineIcons.search,
                    iconColor: Colors.white,
                    text: 'Search',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    iconColor: Colors.white,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
