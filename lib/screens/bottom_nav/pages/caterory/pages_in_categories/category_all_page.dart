import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/model/new_product%20model.dart';
import 'package:tuni/provider/product_provider.dart';

import '../../Home/pages_in_home_page/product_detail_page.dart';
import '../categories_refactor.dart';

class AllCategory extends StatefulWidget {
  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  @override
  void initState() {
    super.initState();
    // Provider.of<ProdcuctProvider>(context, listen: false).fetchallproduct();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProdcuctProvider>(context);
    final List<Productdetails> products = productProvider.Allproducts;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'All',
          style: TextStyle(letterSpacing: 3, fontSize: 20),
        ),
        toolbarHeight: 60,
      ),
      body: products.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .72,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
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
                          category: product.name,
                          gender: product.gender,
                          time: product.time,
                        ),
                      ),
                    );
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
