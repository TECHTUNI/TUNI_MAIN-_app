import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuni/bloc/produtbloc/bloc/product_bloc_bloc.dart';
import 'package:tuni/screens/category/pages/cat1.dart';

import '../../../../category/new_cat.dart';

class ExploreItemsInHomePage extends StatelessWidget {
  const ExploreItemsInHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          // MainPageGridViewProductList(firestore: firestore),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                List<String> images = [
                  "Assets/home_page/tshirts.png",
                  "Assets/home_page/jeans.png",
                  "Assets/home_page/sweatshirts.png",
                  "Assets/home_page/shirts.png",
                ];
                return InkWell(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CAt()));
                    }
                  },
                  child: GridTile(
                      child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(images[index]))),
                  )),
                );
              },
            ),
          ),
          // Positioned(
          //   top: 0,
          //   child: Padding(
          //     padding:
          //     const EdgeInsets.symmetric(horizontal: 25.0),
          //     child: SizedBox(
          //       child:
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
