import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  //int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {  
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff2f3033),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: const Color.fromARGB(255, 56, 56, 56),
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: [
              const GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              const GButton(
                icon: LineIcons.heart,
                text: 'Likes',
               
              ),
              GButton(
                icon: LineIcons.search,
                text: 'Search',
                onPressed: (){
                  
                },
              ),
              const GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
