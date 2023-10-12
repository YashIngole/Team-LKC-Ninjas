import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahayak/auth ui/register_ui.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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
