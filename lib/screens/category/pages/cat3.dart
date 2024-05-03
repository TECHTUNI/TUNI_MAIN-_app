import 'package:flutter/material.dart';
import 'package:tuni/model/product_model.dart';
import 'package:tuni/screens/bottom_nav/pages/caterory/categories_refactor.dart';

class Cat3 extends StatelessWidget {
  Cat3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 100,
              child: productView(
                'Mens t-shirt',
                '199',
                'https://fullyfilmy.in/cdn/shop/products/New-Mockups---no-hanger---TShirt-Yellow.jpg?v=1639657077',
              ),
            );
          },
        ),
      ),
    );
  }
}
