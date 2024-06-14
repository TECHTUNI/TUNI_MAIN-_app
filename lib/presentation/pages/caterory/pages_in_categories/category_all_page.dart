// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tuni/presentation/pages/Home/pages_in_home_page/product_detail_page.dart';
// import '../../../../core/model/product_category_model.dart';
// import '../../../../core/provider/product_provider.dart';
// import '../categories_refactor.dart';

// import 'package:shimmer/shimmer.dart'; // Import Shimmer package

// class AllCategory extends StatefulWidget {
//   final List<ProductCategory>? allProductList;

//   AllCategory({this.allProductList, super.key});

//   @override
//   State<AllCategory> createState() => _AllCategoryState();
// }

// class _AllCategoryState extends State<AllCategory> {
//   late Future<List<ProductCategory>> _fetchAllProductsFuture;

//   @override
//   void initState() {
//     _fetchAllProductsFuture =
//         Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Platform.isAndroid
//         ? Scaffold(
//             appBar: AppBar(
//               foregroundColor: Colors.black,
//               title: const Text(
//                 'All',
//                 style: TextStyle(letterSpacing: 3, fontSize: 20),
//               ),
//               toolbarHeight: 60,
//             ),
//             body: FutureBuilder<List<ProductCategory>>(
//               future: _fetchAllProductsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: Shimmer.fromColors(
//                       // Use Shimmer here
//                       baseColor: Colors.grey[300]!,
//                       highlightColor: Colors.grey[100]!,
//                       child: GridView.builder(
//                         padding: const EdgeInsets.all(5),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           childAspectRatio: 1,
//                           mainAxisSpacing: 5,
//                           crossAxisSpacing: 5,
//                         ),
//                         itemCount: 10,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             height: 100,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Error: ${snapshot.error}'),
//                   );
//                 } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//                   return const Center(
//                     child: Text("Currently this category not available"),
//                   );
//                 } else {
//                   return GridView.builder(
//                     padding: const EdgeInsets.all(2),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: .55,
//                     ),
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final ProductCategory product = snapshot.data![index];
//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductDetailPage(
//                                 productId: product.id,
//                                 productName: product.name,
//                                 imageUrl: product.imageUrlList,
//                                 color: product.color,
//                                 brand: product.brand,
//                                 price: product.price,
//                                 size: product.size,
//                                 category: "",
//                                 gender: product.gender,
//                                 time: product.time,
//                               ),
//                             ),
//                           );
//                         },
//                         child: productView(product.name,
//                             product.price.toString(), product.imageUrlList[0]),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           )
//         : CupertinoPageScaffold(
//             navigationBar: const CupertinoNavigationBar(
//               // foregroundColor: Colors.black,
//               middle: Text(
//                 'All',
//                 style: TextStyle(letterSpacing: 3, fontSize: 20),
//               ),
//               // toolbarHeight: 60,
//             ),
//             child: FutureBuilder<List<ProductCategory>>(
//               future: _fetchAllProductsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CupertinoActivityIndicator(),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Error: ${snapshot.error}'),
//                   );
//                 } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//                   return const Center(
//                     child: Text("Currently this category not available"),
//                   );
//                 } else {
//                   return GridView.builder(
//                     padding: const EdgeInsets.all(10),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: .72,
//                     ),
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final ProductCategory product = snapshot.data![index];
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             CupertinoPageRoute(
//                               builder: (context) => ProductDetailPage(
//                                 productId: product.id,
//                                 productName: product.name,
//                                 imageUrl: product.imageUrlList,
//                                 color: product.color,
//                                 brand: product.brand,
//                                 price: product.price,
//                                 size: product.size,
//                                 category: "",
//                                 gender: product.gender,
//                                 time: product.time,
//                               ),
//                             ),
//                           );
//                         },
//                         child: productView(product.name,
//                             product.price.toString(), product.imageUrlList[0]),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/model/product_category_model.dart';
import '../../../../core/provider/product_provider.dart';
import '../../Home/pages_in_home_page/product_detail_page.dart';
import '../categories_refactor.dart';

class AllCategory extends StatefulWidget {
  final List<ProductCategory>? allProductList;

  const AllCategory({this.allProductList, Key? key}) : super(key: key);

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  late Future<List<ProductCategory>> _fetchAllProductsFuture;

  @override
  void initState() {
    _fetchAllProductsFuture =
        Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();
    super.initState();
  }

  String selectedFilter = 'All';
  String selectedSort = 'None';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All',
          style: TextStyle(letterSpacing: 3, fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<ProductCategory>>(
        future: _fetchAllProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Currently this category not available"),
            );
          } else {
            List<ProductCategory> filteredProducts = snapshot.data!;
            if (selectedFilter != 'All') {
              filteredProducts = filteredProducts
                  .where((product) => product.price == selectedFilter)
                  .toList();
            }

            if (selectedSort == 'High to Low') {
              filteredProducts.sort((a, b) =>
                  double.parse(b.price).compareTo(double.parse(a.price)));
            } else if (selectedSort == 'Low to High') {
              filteredProducts.sort((a, b) =>
                  double.parse(a.price).compareTo(double.parse(b.price)));
            }

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .72,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final ProductCategory product = filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                productId: product.id,
                                productName: product.name,
                                imageUrl: product.imageUrlList,
                                color: product.color,
                                brand: product.brand,
                                price: product.price,
                                size: product.size,
                                category: "",
                                gender: product.gender,
                                time: product.time,
                              ),
                            ),
                          );
                        },
                        child: productView(product.name,
                            product.price.toString(), product.imageUrlList[0]),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Platform.isAndroid
                            ? buildSortButton(screenWidth)
                            : SizedBox(),
                        Container(
                          height: 30,
                          width: 1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white)),
                        ),
                        Platform.isAndroid
                            ? buildFilterButton(screenWidth)
                            : SizedBox(),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildSortButton(double screenWidth) {
    return GestureDetector(
      onTap: () {
        showSortDialog();
      },
      child: Container(
        height: 40,
        width: screenWidth * .35,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sort,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text("SORT")
          ],
        ),
      ),
    );
  }

  Widget buildFilterButton(double screenWidth) {
    return GestureDetector(
      onTap: () {
        showFilterDialog();
      },
      child: Container(
        height: 40,
        width: screenWidth * .35,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_alt,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text("FILTER")
          ],
        ),
      ),
    );
  }

  void showSortDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sort'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('High to Low'),
                onTap: () {
                  setState(() {
                    selectedSort = 'High to Low';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Low to High'),
                onTap: () {
                  setState(() {
                    selectedSort = 'Low to High';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('All'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'All';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Your Filter Option 1'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'Your Filter Option 1';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Your Filter Option 2'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'Your Filter Option 2';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
