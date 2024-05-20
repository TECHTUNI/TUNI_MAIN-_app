import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/model/product_category_model.dart';
import 'package:tuni/core/provider/product_provider.dart';
import 'package:tuni/presentation/pages/Home/pages_in_home_page/product_detail_page.dart';

import '../../caterory/categories_refactor.dart';

class ProductsItemView extends StatefulWidget {
  final String type;
  final String model;
  final List<ProductCategory> productList;

  const ProductsItemView(
      {super.key,
      required this.type,
      required this.model,
      required this.productList});

  @override
  ProductsItemViewState createState() => ProductsItemViewState();
}

class ProductsItemViewState extends State<ProductsItemView> {
  @override
  void initState() {
    debugPrint('details inside category widger${widget.type}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false)
        .fetchallproduct(widget.type, widget.model);
    // final productProvider = Provider.of<ProductProvider>(context);
    // final List<ProductCategory> typewise = productProvider.Allproducts;


    return Container(
      constraints: const BoxConstraints.expand(),
      child: widget.productList.isEmpty
          ? const Center(
              child: Text("Currently this category is not available"),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemCount: widget.productList.length,
              itemBuilder: (BuildContext context, int index) {
                ProductCategory product = widget.productList[index];
                String productName = product.name;
                String productId = product.id;
                List imageUrlList = product.imageUrlList;
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
                        MaterialPageRoute(
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
                    product.imageUrlList[0],
                  ),
                );
              },
            ),
    );
  }
}

// class ProductsItemViewState extends State<ProductsItemView> {
//   late Future<List<ProductCategory>> _cachedProductListFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _cachedProductListFuture = getCachedProductList();
//   }
//
//   final String _keyCachedProductList = 'cached_product_list';
//
//   Future<List<ProductCategory>> getCachedProductList() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final String? jsonData = prefs.getString(_keyCachedProductList);
//       if (jsonData != null && jsonData.isNotEmpty) {
//         final decodedData = json.decode(jsonData) as List<dynamic>;
//         final productList = decodedData
//             .map((itemJson) => ProductCategory.fromJson(itemJson))
//             .toList();
//         return productList;
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print('Error retrieving cached product list: $e');
//       throw e.toString();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<ProductCategory>>(
//       future: _cachedProductListFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text('Error: ${snapshot.error}'),
//           );
//         } else {
//           final productList = snapshot.data ?? [];
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//               childAspectRatio: 0.65,
//             ),
//             itemCount: productList.length,
//             itemBuilder: (BuildContext context, int index) {
//               final product = productList[index];
//               return productView(
//                   product.name, product.price, product.imageUrlList.toString());
//             },
//           );
//         }
//       },
//     );
//   }
// }
