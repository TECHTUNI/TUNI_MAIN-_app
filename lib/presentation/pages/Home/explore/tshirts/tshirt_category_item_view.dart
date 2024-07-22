import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tuni/presentation/pages/caterory/categories_refactor.dart';
import '../../../../../core/model/product_model.dart';
import '../../../../../core/provider/tshirt_category_provider.dart';
import '../../pages_in_home_page/product_detail_page.dart';

class TShirtCategoryItemView extends StatefulWidget {
  final String type;
  final String category;

  const TShirtCategoryItemView(
      {required this.type, required this.category, super.key});

  @override
  State<TShirtCategoryItemView> createState() => _TShirtCategoryItemViewState();
}

class _TShirtCategoryItemViewState extends State<TShirtCategoryItemView> {
  @override
  void initState() {
    super.initState();
    final provider =
        Provider.of<TShirtCategoryProvider>(context, listen: false);
    if (widget.type == "All") {
      provider.fetchAllTShirts();
    } else if (widget.type == "Full Sleeve") {
      provider.fetchAndCombineFullSleeveTShirts();
    } else if (widget.type == "Half Sleeve") {
      provider.fetchAndCombineHalfSleeveTShirts();
    } else if (widget.type == "Collar") {
      provider.fetchAndCombineCollarTShirts();
    } else if (widget.type == "Round Neck") {
      provider.fetchAndCombineRoundNeckTShirts();
    } else if (widget.type == "V Neck") {
      provider.fetchAndCombineVNeckTShirts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TShirtCategoryProvider>(
        builder: (context, provider, child) {
      if (widget.type == "All") {
        return FutureBuilder(
          future: provider.fetchAllTShirts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final allTShirtsList = provider.allTShirts;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemCount: allTShirtsList.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = allTShirtsList[index];
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
                    child: productView(
                      product.name,
                      product.price.toString(),
                      product.imageUrl[0],
                    ),
                  );
                },
              );
            }
          },
        );
      } else if (widget.type == "Full Sleeve") {
        return FutureBuilder(
          future: provider.fetchAndCombineFullSleeveTShirts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final allFullSleeveTShirtsList = provider.allFullSleeveTShirts;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemCount: allFullSleeveTShirtsList.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = allFullSleeveTShirtsList[index];
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
                    child: productView(
                      product.name,
                      product.price.toString(),
                      product.imageUrl[0],
                    ),
                  );
                },
              );
            }
          },
        );
      } else if (widget.type == "Half Sleeve") {
        return FutureBuilder(
          future: provider.fetchAndCombineHalfSleeveTShirts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final allHalfSleeveTShirtsList = provider.allHalfSleeveTShirts;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemCount: allHalfSleeveTShirtsList.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = allHalfSleeveTShirtsList[index];
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
                    child: productView(
                      product.name,
                      product.price.toString(),
                      product.imageUrl[0],
                    ),
                  );
                },
              );
            }
          },
        );
      } else if (widget.type == "Collar") {
        return FutureBuilder(
          future: provider.fetchAndCombineCollarTShirts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final allCollarTShirts = provider.allCollarTShirts;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemCount: allCollarTShirts.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = allCollarTShirts[index];
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
                    child: productView(
                      product.name,
                      product.price.toString(),
                      product.imageUrl[0],
                    ),
                  );
                },
              );
            }
          },
        );
      } else if (widget.type == "Round Neck") {
        return FutureBuilder(
          future: provider.fetchAndCombineRoundNeckTShirts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final allRoundNeckTShirtsList = provider.allRoundNeckTShirts;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemCount: allRoundNeckTShirtsList.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = allRoundNeckTShirtsList[index];
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
                    child: productView(
                      product.name,
                      product.price.toString(),
                      product.imageUrl[0],
                    ),
                  );
                },
              );
            }
          },
        );
      } else if (widget.type == "V Neck") {
        return FutureBuilder(
          future: provider.fetchAndCombineVNeckTShirts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final allVNeckTShirtsList = provider.allVNeckTShirts;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemCount: allVNeckTShirtsList.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = allVNeckTShirtsList[index];
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
                    child: productView(
                      product.name,
                      product.price.toString(),
                      product.imageUrl[0],
                    ),
                  );
                },
              );
            }
          },
        );
      } else {
        return const Column(
          children: [
            Center(child: Text("Error Loading data, Please try again later")),
          ],
        );
      }
    });
  }
}
