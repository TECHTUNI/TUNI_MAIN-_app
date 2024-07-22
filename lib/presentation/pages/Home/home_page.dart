import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/presentation/pages/Home/platforms/andoid_home_refactor.dart';
//import 'package:tuni/presentation/pages/Home/platforms/android_home_refactor.dart'; // Adjust import to point to your Android-specific home page

import '../../../core/model/product_category_model.dart';
import '../../../core/provider/product_provider.dart';

class HomePage extends StatefulWidget {
  final List<String> model = [
    "full sleve",
    "half sleve",
    "collar",
    "round neck",
    "v-neck"
  ];
  final List<String> type = ["Pant", "Shirt", "Tshirt", "Shorts"];

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .fetchallproduct("Tshirt", "full sleve");
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final List<ProductCategory> allProductsList = provider.Allproducts;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return AndroidHome(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      productList: allProductsList,
    );
  }
}
