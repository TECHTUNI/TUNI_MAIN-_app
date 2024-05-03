import 'package:flutter/material.dart';

import '../../../model/new_product model.dart';

class Cat2 extends StatelessWidget {
  final List<Productdetails> products;
  Cat2({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      color: Colors.white,
      child:
          // GridView.builder(
          //   padding: const EdgeInsets.all(10),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: _calculateCrossAxisCount(mediaQuery),
          //     childAspectRatio: .72,
          //   ),
          //   itemCount: products.length,
          //   itemBuilder: (context, index) {
          //     final Productdetails product = products[index];
          //     return InkWell(
          //       onTap: () {
          //         // Handle onTap
          //       },
          //       child: Container(
          //         child: Column(
          //           children: [
          //             Text(product.brand),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          Text('hiiiiiiiiiiiii'),
    );
  }

  int _calculateCrossAxisCount(MediaQueryData mediaQuery) {
    double screenWidth = mediaQuery.size.width;
    double itemWidth = 170; // Width of each grid item
    int crossAxisCount = screenWidth ~/ itemWidth;
    return crossAxisCount;
  }
}
