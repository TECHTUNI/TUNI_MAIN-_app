// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../../drawer/drawer.dart';
// import 'home_refactor.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final firestore =
//       FirebaseFirestore.instance.collection('Clothes').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       drawer: DrawerWidget(),
//       body: NestedScrollView(
//         floatHeaderSlivers: true,
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return [
//             MainPageSliverAppBar(),
//           ];
//         },
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const MainPageCarouselSlider(),
//               const SizedBox(height: 35),
//               mainPageHeading('Explore'),
//               MainPageGridViewProductList(firestore: firestore),
//               const MainPageSeeMoreTextButton(),
//               const SizedBox(height: 30),
//               mainPageHeading('Filter by CATEGORY'),
//               MainPageFilterByCategory(
//                   screenWidth: screenWidth, screenHeight: screenHeight),
//               const Divider()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widget/android.dart';
import 'widget/ios.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore =
      FirebaseFirestore.instance.collection('Clothes').snapshots();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Platform.isAndroid
        ? AndroidHome(screenWidth: screenWidth, screenHeight: screenHeight)
        : IosHome(screenWidth: screenWidth, screenHeight: screenHeight);
  }
}
