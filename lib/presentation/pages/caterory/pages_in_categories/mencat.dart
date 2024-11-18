import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/presentation/pages/caterory/pages_in_categories/category_all_page.dart';

import '../../../../core/model/product_category_model.dart';
import '../../../../core/provider/product_provider.dart';
import '../../Home/pages_in_home_page/product_detail_page.dart';
import '../categories_refactor.dart';

class AllCategorynew extends StatefulWidget {
  final List<ProductCategory>? allProductList;

  const AllCategorynew({this.allProductList, super.key});

  @override
  _AllCategoryState createState() => _AllCategoryState();
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
        title: const Text(
          'MEN',
          style: TextStyle(letterSpacing: 3, fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<ProductCategory>>(
        future: _fetchAllProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Currently this category not available"),
            );
          } else {
            List<ProductCategory> filteredProducts = snapshot.data!;
            if (selectedFilter != 'All') {
              filteredProducts = filteredProducts
                  .where((product) => product.type == selectedFilter)
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
                      childAspectRatio: .75,
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
                            : const SizedBox(),
                        Container(
                          height: 30,
                          width: 1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white)),
                        ),
                        Platform.isAndroid
                            ? buildFilterButton(screenWidth)
                            : const SizedBox(),
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
        child: const Row(
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
        child: const Row(
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
          title: const Text('Sort'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('High to Low'),
                onTap: () {
                  setState(() {
                    selectedSort = 'High to Low';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Low to High'),
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
          backgroundColor: Colors.white,
          //alignment: Alignment.bottomCenter,

          title: const Text('Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('All'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'All';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('full sleve'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'full sleve';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('half sleve'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'half sleve';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('V-NECK'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'v-neck';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Collor'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'collor';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('round neck'),
                onTap: () {
                  setState(() {
                    selectedFilter = 'round neck';
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
