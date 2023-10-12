import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sahayak/user/home.dart';
import 'package:sahayak/user/planetlistview.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    super.key,
    required this.controller,
  });

  final CarouselController controller;

  @override
  Widget build(BuildContext context) {
    Home home = const Home();

    final List<Widget> planetWidgets = [
      const DevopsTools(
        scaleX: 2,
        scaleY: 2,
        assetImage: AssetImage(
            'assets/101254862-vector-electircian-repairing-socket-flat-design-removebg-preview.png'),
        planetName: "Electrician",
        description: 'mercury_desc',
        InitialVal: "Electrician",
      ),
      const DevopsTools(
        scaleX: 2,
        scaleY: 2,
        assetImage: AssetImage('assets/plumber-removebg-preview.png'),
        planetName: "Plumber",
        description: "venus_desc",
        InitialVal: "Plumber",
      ),
      const DevopsTools(
        scaleX: 2,
        scaleY: 2,
        assetImage: AssetImage('assets/maid-removebg-preview.png'),
        planetName: 'Maid',
        description: 'earth_desc',
        InitialVal: "Maid",
      ),
      const DevopsTools(
        scaleX: 2,
        scaleY: 2,
        assetImage: AssetImage('assets/carpenterconv-removebg.png'),
        planetName: "Carpenter",
        description: 'mars_desc',
        InitialVal: "Carpenter",
      ),
      const DevopsTools(
        scaleX: 2.45,
        scaleY: 2.45,
        assetImage: AssetImage('assets/construction-removebg.png'),
        planetName: "Construction",
        description: 'saturn_desc',
        InitialVal: "Construction",
      ),
      // DevopsTools(
      //   scaleX: 2,
      //   scaleY: 2,
      //   assetImage: const AssetImage('Assets/terraform.png'),
      //   planetName: 'Helper',
      //   description: 'jupiter_desc',
      //   onTap: () {},
      // ),
      // DevopsTools(
      //   scaleX: 2.55,
      //   scaleY: 2.55,
      //   assetImage: const AssetImage('Assets/docker.png'),
      //   planetName: "Docker",
      //   description: 'uranus_desc',
      //   onTap: () {},
      // ),
      // DevopsTools(
      //   scaleX: 2,
      //   scaleY: 2,
      //   assetImage: const AssetImage('Assets/kubernetes.png'),
      //   planetName: 'Kubernetes',
      //   description: 'neptune_desc',
      //   onTap: () {},
      // ),
    ];

    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(430, 932),
      builder: (context, child) {
        return CarouselSlider(
          options: CarouselOptions(
            padEnds: false,
            enlargeFactor: 0.1,

            // animateToClosest: true,

            disableCenter: false,
            enlargeCenterPage: true,
            height: 250.sp,

            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: false,
            viewportFraction: 0.5,
          ),
          carouselController: controller,
          items: planetWidgets,
        );
      },
    );
  }
}

void navigateToDetailScreen(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
