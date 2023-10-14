import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:sahayak/Themeconst.dart';
import 'package:sahayak/user/SearchWorkers.dart';

class DevopsTools extends StatelessWidget {
  final double? scaleY;
  final double? scaleX;
  final String planetName;
  final String description;
  // final String kilometresFromTheSun;
  // final String size;
  // final String temperature;
  // final String additionalInfo;
  final ImageProvider assetImage;
  // final String tag;
  final String InitialVal;

  const DevopsTools({
    super.key,
    required this.assetImage,
    required this.planetName,
    this.scaleY,
    this.scaleX,
    required this.description,
    required this.InitialVal,
    // required this.kilometresFromTheSun,
    // required this.size,
    // required this.temperature,
    // required this.additionalInfo,
    // required this.onTap,
    // required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (context, child) {
        return SizedBox(
          width: w,
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchWorkers(InitialVal: InitialVal),
      ),
    );
                 // Get.to(SearchWorkers(InitialVal: InitialVal));
                },
                child: Container(
                  height: 250.sp,
                  width: 200.sp,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                      bottom: Radius.circular(20),
                    ),
                    color: ktilecolor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 13.0,
                      right: 13.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: assetImage,
                        ),
                        const Spacer(),
                        Center(
                          child: Text(
                            planetName,
                            style: GoogleFonts.poppins(
                              fontSize: 23.sp,
                              color: const Color.fromARGB(255, 200, 201, 202),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
