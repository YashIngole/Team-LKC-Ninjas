import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sahayak/Themeconst.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/sahayak.png')
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .shimmer(duration: 1.seconds),
          ),
          const SpinKitThreeInOut(
            color: Colors.white,
          )
        ],
      )),
    );
  }
}
