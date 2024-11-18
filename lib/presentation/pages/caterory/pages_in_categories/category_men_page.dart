import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/model/product_category_model.dart';
import '../../../../core/provider/product_provider.dart';
import '../../Home/pages_in_home_page/product_detail_page.dart';
import '../categories_refactor.dart';

class MenCategory extends StatefulWidget {
  const MenCategory({super.key});

  @override
  State<MenCategory> createState() => _MenCategoryState();
}

class _MenCategoryState extends State<MenCategory> {
  late Future<List<ProductCategory>> _fetchAllProductsFuture;
  String selectedFilter = 'All';
  String selectedSort = 'None';

  @override
  void initState() {
    super.initState();
    _fetchAllProductsFuture =
        Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Men'.toUpperCase(),
          style: const TextStyle(letterSpacing: 3, fontSize: 20),
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
              child: Text("Currently this category is not available"),
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
                                category: product.type,
                                gender: product.gender,
                                time: product.time,
                              ),
                            ),
                          );
                        },
                        child: productView(
                          product.name,
                          product.price,
                          product.imageUrlList[0],
                        ),
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
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    "SORT",
                                    style: TextStyle(letterSpacing: 2),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedSort = 'High to Low';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "High to Low",
                                          style: TextStyle(
                                            fontWeight:
                                                selectedSort == 'High to Low'
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedSort = 'Low to High';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Low to High",
                                          style: TextStyle(
                                            fontWeight:
                                                selectedSort == 'Low to High'
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 40,
                            width: screenWidth * .35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
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
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white)),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Filter",
                                    style: TextStyle(letterSpacing: 2),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedFilter = 'All';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "All",
                                          style: TextStyle(
                                            fontWeight: selectedFilter == 'All'
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedFilter = 'full sleve';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Full Sleeve",
                                          style: TextStyle(
                                            fontWeight:
                                                selectedFilter == 'full sleve'
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedFilter = 'half sleve';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Half Sleeve",
                                          style: TextStyle(
                                            fontWeight:
                                                selectedFilter == 'half sleve'
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedFilter = 'collar';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Collar",
                                          style: TextStyle(
                                            fontWeight:
                                                selectedFilter == 'collar'
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedFilter = 'round neck';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Round Neck",
                                          style: TextStyle(
                                            fontWeight:
                                                selectedFilter == 'round neck'
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedFilter = 'v-neck';
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "V-Neck",
                                          style: TextStyle(
                                            fontWeight:
                                                selectedFilter == 'v-neck'
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 40,
                            width: screenWidth * .35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
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
                        )
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
}
