import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/model/product_category_model.dart';
import 'package:tuni/core/provider/tshirt_category_provider.dart';
import 'package:tuni/presentation/pages/Home/explore/tshirts/tshirts_in_explore.dart';
import '../../combo/combo.dart';
import '../../search/search_widget.dart';
import '../explore/tshirts/refactor_tshirt_category.dart';
import '../home_refactor.dart';

class AndroidHome extends StatefulWidget {
  const AndroidHome({
    Key? key,
    required this.screenWidth,
    required this.screenHeight, required List<ProductCategory> productList,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  _AndroidHomeState createState() => _AndroidHomeState();
}

class _AndroidHomeState extends State<AndroidHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<TShirtCategoryProvider>(context, listen: false)
          .fetchAllTShirts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TUNi",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const MainPageCarouselSlider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mainPageHeading('Combos'),
                        const SizedBox(
                          width: 0,
                        ),
                        ViewAllButton(
                          className: ComboPage,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MainPageComboListing(
                    screenWidth: widget.screenWidth,
                    screenHeight: widget.screenHeight,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mainPageHeading('T-shirts'),
                        const SizedBox(
                          width: 0,
                        ),
                        ViewAllButton(
                          className: TShirtsInExplore,
                        ),
                      ],
                    ),
                  ),
                  TShirtsInHomePage(
                    screenHeight: widget.screenHeight,
                    screenWidth: widget.screenWidth,
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
