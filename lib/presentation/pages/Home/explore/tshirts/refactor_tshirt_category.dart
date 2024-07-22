import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/model/product_model.dart';
import '../../../../../core/provider/tshirt_category_provider.dart';
import '../../pages_in_home_page/product_detail_page.dart';

class ItemTypeContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() onTap;

  const ItemTypeContainer({
    required this.onTap,
    required this.text,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black87 : CupertinoColors.white,
          border: isSelected
              ? Border.all(width: 0)
              : Border.all(color: CupertinoColors.systemGrey2),
          // borderRadius: BorderRadius.circular(12)
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: isSelected ? CupertinoColors.white : CupertinoColors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 1,
            fontSize: isSelected ? 13 : 10,
          ),
        ),
      ),
    );
  }
}

class TShirtsInHomePage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const TShirtsInHomePage(
      {super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Consumer<TShirtCategoryProvider>(
      builder: (context, tShirtProvider, child) {
        if (tShirtProvider.allTShirts.isEmpty) {
          return SizedBox(
            width: double.infinity,
            height: 250,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: .58,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: screenWidth * 0.95,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 10,
                            width: 100,
                          )),
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 10,
                            width: screenWidth * 0.95,
                          )),
                      const SizedBox(height: 5),
                      Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 10,
                            width: screenWidth * 0.95,
                          )),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          List<Product> allTshirts = tShirtProvider.allTShirts;

          return Center(
            child: SizedBox(
              width: screenWidth * 0.95,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: .58,
                ),
                itemCount: min(4, allTshirts.length),
                itemBuilder: (context, index) {
                  String productPrice = allTshirts[index].price;
                  List image = allTshirts[index].imageUrl;
                  List sizesAvailable = allTshirts[index].size;
                  Product product = allTshirts[index];
                  String productName = product.name;
                  String productId = product.id;
                  List imageUrlList = product.imageUrl;
                  String color = product.color;
                  String brand = product.brand;
                  // price = product.price;
                  String category = product.brand;
                  List size = product.size;
                  String price = product.price;
                  String gender = product.gender;
                  String time = product.time;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProductDetailPage(
                                productId: productId,
                                productName: productName,
                                imageUrl: imageUrlList,
                                color: color,
                                brand: brand,
                                price: price,
                                size: size,
                                category: category,
                                gender: gender,
                                time: time),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Image.network(
                              image[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            productName,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "₹ $productPrice.00",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 5),
                          AvailableSizes(
                            availableSizes: sizesAvailable,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}

class AvailableSizes extends StatelessWidget {
  final List availableSizes;
  final List<String> allSizes = ['S', 'M', 'L', 'XL', 'XXL'];

  AvailableSizes({required this.availableSizes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: allSizes.map((size) {
        bool isAvailable = availableSizes.contains(size);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            width: 25,
            height: 20,
            decoration: BoxDecoration(
              border: Border.all(
                color: CupertinoColors.inactiveGray,
                width: 0.5,
              ),
            ),
            child: Center(
              child: Text(
                size,
                style: TextStyle(
                  decoration: isAvailable
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                  color: isAvailable
                      ? CupertinoColors.black
                      : CupertinoColors.destructiveRed,
                  fontSize: 9,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
