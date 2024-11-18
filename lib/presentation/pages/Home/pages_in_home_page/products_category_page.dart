// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tuni/core/provider/product_provider.dart';
// import 'package:tuni/presentation/pages/Home/pages_in_home_page/products_category_item_view_widget.dart';

// import '../../../../core/model/product_category_model.dart';

// class ProductsCategoryInExplore extends StatefulWidget {
//   final List<String> model = [
//     "full sleve",
//     "half sleve",
//     "collar",
//     "round neck",
//     "v-neck"
//   ];
//   final List<String> type = ["Pant", "Shirt", "Tshirt", "Shorts"];

//   List<ProductCategory> productList;

//   ProductsCategoryInExplore({super.key, required this.productList});

//   @override
//   ProductsCategoryInExploreState createState() =>
//       ProductsCategoryInExploreState();
// }

// class ProductsCategoryInExploreState extends State<ProductsCategoryInExplore> {
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _onIndexChanged(int newIndex) {
//     setState(() {
//       _selectedIndex = newIndex;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Platform.isIOS
//         ? CupertinoPageScaffold(
//             navigationBar: CupertinoNavigationBar(
//               middle: const Text('EXPLORE'),
//             ),
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return Consumer<ProductProvider>(
//                   builder: (context, productProvider, Widget? child) {
//                     return Container(
//                       width: constraints.maxWidth,
//                       color: CupertinoColors.black,
//                       child: Column(
//                         children: [
//                           _buildHorizontalListView(),
//                           Expanded(
//                             child: Container(
//                               color: CupertinoColors.white,
//                               child: Center(
//                                 child: _getScreenForIndex(_selectedIndex),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               title: const Text('EXPLORE'),
//             ),
//             body: LayoutBuilder(
//               builder: (context, constraints) {
//                 return Consumer<ProductProvider>(
//                   builder: (context, productProvider, Widget? child) {
//                     return Container(
//                       width: constraints.maxWidth,
//                       color: Colors.black,
//                       child: Column(
//                         children: [
//                           _buildHorizontalListView(),
//                           Expanded(
//                             child: Container(
//                               color: Colors.white,
//                               child: Center(
//                                 child: _getScreenForIndex(_selectedIndex),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           );
//   }

//   Widget _buildHorizontalListView() {
//     return Container(
//       height: 35, // Adjust height as needed
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.model.length,
//         itemBuilder: (context, index) {
//           return _buildCircleAvatarWithName(
//             Icons.person,
//             widget.model[index],
//             index,
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCircleAvatarWithName(
//     IconData icon,
//     String name,
//     int index,
//   ) {
//     bool isSelected = index == _selectedIndex;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: GestureDetector(
//         onTap: () {
//           _onIndexChanged(index);
//         },
//         child: Container(
//           height: 35,
//           width: 100, // Adjust width as needed
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(8),
//             color: isSelected ? Colors.blueGrey.shade100 : Colors.transparent,
//           ),
//           child: Center(
//             child: Text(
//               name.toUpperCase(),
//               style: TextStyle(
//                 color: isSelected ? Colors.black : Colors.grey.shade500,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 letterSpacing: 1,
//                 fontSize: isSelected ? 13 : 12,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _getScreenForIndex(int index) {
//     debugPrint('selected index${index}');
//     switch (index) {
//       case 0:
//         return ProductsItemView(
//           type: 'Tshirt',
//           model: widget.model[index],
//           productList: widget.productList,
//         );
//       case 1:
//         return ProductsItemView(
//           type: 'Tshirt',
//           model: widget.model[index],
//           productList: widget.productList,
//         );
//       case 2:
//         return ProductsItemView(
//           type: 'Tshirt',
//           model: widget.model[index],
//           productList: widget.productList,
//         );
//       case 3:
//         return ProductsItemView(
//           type: 'Tshirt',
//           model: widget.model[index],
//           productList: widget.productList,
//         );
//       case 4:
//         return ProductsItemView(
//           type: 'Shirt',
//           model: widget.model[index],
//           productList: widget.productList,
//         );
//       default:
//         return Container();
//     }
//   }
// }
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/provider/product_provider.dart';
import 'package:tuni/presentation/pages/Home/pages_in_home_page/products_category_item_view_widget.dart';

import '../../../../core/model/product_category_model.dart';

class ProductsCategoryInExplore extends StatefulWidget {
  final List<String> model = [
    "full sleve",
    "half sleve",
    "collar",
    "round neck",
    "v-neck"
  ];
  final List<String> type = ["Pant", "Shirt", "Tshirt", "Shorts"];

  List<ProductCategory> productList;

  ProductsCategoryInExplore({super.key, required this.productList});

  @override
  ProductsCategoryInExploreState createState() =>
      ProductsCategoryInExploreState();
}

class ProductsCategoryInExploreState extends State<ProductsCategoryInExplore> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onIndexChanged(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('EXPLORE'),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Consumer<ProductProvider>(
                  builder: (context, productProvider, Widget? child) {
                    return Container(
                      width: constraints.maxWidth,
                      color: CupertinoColors.black,
                      child: Column(
                        children: [
                          _buildHorizontalListView(),
                          Expanded(
                            child: Container(
                              color: CupertinoColors.white,
                              child: Center(
                                child: _getScreenForIndex(_selectedIndex),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('EXPLORE'),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Consumer<ProductProvider>(
                  builder: (context, productProvider, Widget? child) {
                    return Container(
                      width: constraints.maxWidth,
                      color: Colors.white,
                      child: Column(
                        children: [
                          _buildHorizontalListView(),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: _getScreenForIndex(_selectedIndex),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
  }

  Widget _buildHorizontalListView() {
    return SizedBox(
      height: 35, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.model.length,
        itemBuilder: (context, index) {
          return _buildCircleAvatarWithName(
            Icons.person,
            widget.model[index],
            index,
          );
        },
      ),
    );
  }

  Widget _buildCircleAvatarWithName(
    IconData icon,
    String name,
    int index,
  ) {
    bool isSelected = index == _selectedIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          _onIndexChanged(index);
        },
        child: Container(
          height: 35,
          width: 100, // Adjust width as needed
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(30),
            color: isSelected
                ? const Color.fromARGB(255, 0, 3, 3)
                : Colors.transparent,
          ),
          child: Center(
            child: Text(
              name.toUpperCase(),
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : const Color.fromARGB(255, 2, 0, 0),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 1,
                fontSize: isSelected ? 13 : 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getScreenForIndex(int index) {
    debugPrint('selected index${index}');
    switch (index) {
      case 0:
        return ProductsItemView(
          type: 'Tshirt',
          model: widget.model[index],
          productList: widget.productList,
        );
      case 1:
        return ProductsItemView(
          type: 'Tshirt',
          model: widget.model[index],
          productList: widget.productList,
        );
      case 2:
        return ProductsItemView(
          type: 'Tshirt',
          model: widget.model[index],
          productList: widget.productList,
        );
      case 3:
        return ProductsItemView(
          type: 'Tshirt',
          model: widget.model[index],
          productList: widget.productList,
        );
      case 4:
        return ProductsItemView(
          type: 'Shirt',
          model: widget.model[index],
          productList: widget.productList,
        );
      default:
        return Container();
    }
  }
}
