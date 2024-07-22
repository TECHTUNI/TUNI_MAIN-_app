import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tuni/presentation/pages/caterory/categories_refactor.dart';
import '../../../../../core/model/product_model.dart';
import '../../../../../core/provider/shirt_category_provider.dart';
import '../../pages_in_home_page/product_detail_page.dart';

class ShirtCategoryItemView extends StatefulWidget {
  final String type;
  final String category;

  const ShirtCategoryItemView(
      {required this.type, required this.category, super.key});

  @override
  State<ShirtCategoryItemView> createState() => _ShirtCategoryItemViewState();
}

class _ShirtCategoryItemViewState extends State<ShirtCategoryItemView> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ShirtCategoryProvider>(context, listen: false);
    if (widget.type == "All") {
      provider.fetchAndCombineShirts();
    }
    // else if (widget.type == "Full Sleeve") {
    //   provider.fetchAndCombineFullSleeveTShirts();
    // } else if (widget.type == "Half Sleeve") {
    //   provider.fetchAndCombineHalfSleeveTShirts();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShirtCategoryProvider>(builder: (context, provider, child) {
      provider.fetchAndCombineShirts();
      if (widget.type == "All") {
        return FutureBuilder(
          future: provider.fetchShirts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final allShirtsList = provider.allShirts;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemCount: allShirtsList.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = allShirtsList[index];
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Coming soon...")),
            SizedBox(height: 200)
          ],
        );
      }
    });
  }
}
