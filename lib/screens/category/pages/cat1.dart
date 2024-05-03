import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/model/new_product model.dart';
import 'package:tuni/provider/product_provider.dart';
import 'package:tuni/screens/bottom_nav/pages/caterory/categories_refactor.dart';

class Cat1 extends StatefulWidget {
  final String type;
  final String model;

  const Cat1({Key? key, required this.type, required this.model})
      : super(key: key);

  @override
  _Cat1State createState() => _Cat1State();
}

class _Cat1State extends State<Cat1> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProdcuctProvider>(context, listen: false)
        .fetchallproduct(widget.type, widget.model);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProdcuctProvider>(context);
    final List<Productdetails> typewise = productProvider.Allproducts;

    return Container(
      constraints: BoxConstraints.expand(),
      child: typewise.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 0.6,
              ),
              itemCount: typewise.length,
              itemBuilder: (BuildContext context, int index) {
                final product = typewise[index];
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 100,
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
