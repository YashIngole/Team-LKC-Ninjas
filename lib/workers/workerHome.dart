import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/workers/WorkerRequests.dart';
import 'package:sahayak/workers/workerpage.dart';
import 'package:sahayak/workers/workerprofile.dart';

class WorkerHome extends StatefulWidget {
  const WorkerHome({super.key});

  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final List<Widget> _widgetOptions = <Widget>[
    const workerpage(),
     const workerrequests(),
    const workerprofile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: kbackgroundcolor,
              hoverColor: kbackgroundcolor,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              
              tabBackgroundColor: Colors.white,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  iconColor: Colors.white,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.bell,
                  iconColor: Colors.white,
                  text: 'Requests',
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
    );
  }
}
