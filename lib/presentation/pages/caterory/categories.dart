import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuni/presentation/pages/caterory/platforms/android_category_refactor.dart';
import 'package:tuni/presentation/pages/caterory/platforms/ios_category_refactor.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    //final List<ProductCategory> productList;
    return Platform.isAndroid
        ? AndroidCategoryPage(
            screenWidth: screenWidth, screenHeight: screenHeight)
        : IosCategoryPage(screenWidth: screenWidth, screenHeight: screenHeight);
  }
}
