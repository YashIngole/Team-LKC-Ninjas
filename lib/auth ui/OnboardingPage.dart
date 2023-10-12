import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/auth ui/register_ui.dart';

class type extends StatefulWidget {
  const type({super.key});

  @override
  State<type> createState() => _typeState();
}

class _typeState extends State<type> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Get.to(const Registerpagee(userType: "User"));
              },
              child: const Text("User")),
          ElevatedButton(
              onPressed: () {
                Get.to(const Registerpagee(userType: "Worker"));
              },
              child: const Text("Worker"))
        ],
      ),
    ));
  }
}
