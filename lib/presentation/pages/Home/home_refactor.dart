// // import 'package:carousel_slider/carousel_slider.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:tuni/presentation/bloc/favorite_bloc/favorite_repository.dart';
// // import 'package:tuni/presentation/pages/Home/pages_in_home_page/product_detail_page.dart';
// // import 'package:tuni/presentation/pages/Home/pages_in_home_page/products_category_page.dart';
// // import '../../../core/model/product_category_model.dart';
// // import '../../bloc/favorite_bloc/favorite_bloc.dart';
// // import '../caterory/pages_in_categories/category_all_page.dart';
// // import '../caterory/pages_in_categories/category_kids_page.dart';
// // import '../caterory/pages_in_categories/category_men_page.dart';
// // import '../caterory/pages_in_categories/category_women_page.dart';
// // import '../search/search_widget.dart';
// // import 'pages_in_home_page/Shirt/Shirtcategory.dart';

// // class MainPageSliverAppBar extends StatelessWidget {
// //   const MainPageSliverAppBar({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return SliverAppBar(
// //       foregroundColor: Colors.black,
// //       title: const Text(
// //         'TUNi',
// //         style: TextStyle(
// //           letterSpacing: 8,
// //           fontSize: 30,
// //           fontWeight: FontWeight.w800,
// //         ),
// //       ),
// //       actions: [
// //         IconButton(
// //           onPressed: () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(builder: (context) => const SearchScreen()),
// //             );
// //           },
// //           icon: const Icon(
// //             Icons.search,
// //             size: 35,
// //           ),
// //         ),
// //       ],
// //       floating: true,
// //       snap: true,
// //       toolbarHeight: 80,
// //     );
// //   }
// // }

// // class MainPageFilterByCategory extends StatelessWidget {
// //   const MainPageFilterByCategory({
// //     super.key,
// //     required this.screenWidth,
// //     required this.screenHeight,
// //   });

// //   final double screenWidth;
// //   final double screenHeight;

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //         width: screenWidth,
// //         height: screenHeight * .42,
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Column(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: [
// //                 InkWell(
// //                   onTap: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => AllCategory(),
// //                         ));
// //                   },
// //                   child: mainPageCircularAvatar(
// //                       screenWidth: screenWidth, name: 'ALL'),
// //                 ),
// //                 InkWell(
// //                   onTap: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => MenCategory(),
// //                         ));
// //                   },
// //                   child: mainPageCircularAvatar(
// //                       screenWidth: screenWidth, name: 'MEN'),
// //                 )
// //               ],
// //             ),
// //             Column(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: [
// //                 InkWell(
// //                   onTap: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => WomenCategory(),
// //                         ));
// //                   },
// //                   child: mainPageCircularAvatar(
// //                       screenWidth: screenWidth, name: 'WOMEN'),
// //                 ),
// //                 InkWell(
// //                   onTap: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => KidsCategory(),
// //                         ));
// //                   },
// //                   child: mainPageCircularAvatar(
// //                       screenWidth: screenWidth, name: 'KIDS'),
// //                 )
// //               ],
// //             ),
// //           ],
// //         ));
// //   }
// // }

// // class MainPageSeeMoreTextButton extends StatelessWidget {
// //   final List<ProductCategory> allProductList;
// //   const MainPageSeeMoreTextButton({
// //     required this.allProductList,
// //     super.key,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return TextButton(
// //         onPressed: () {
// //           Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (context) => AllCategory(
// //                   allProductList: allProductList,
// //                 ),
// //               ));
// //         },
// //         child: const Text(
// //           'view all',
// //           style: TextStyle(
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ));
// //   }
// // }

// // class MainPageGridViewProductList extends StatelessWidget {
// //   const MainPageGridViewProductList({
// //     super.key,
// //     // required this.firestore,
// //   });

// //   // final Stream<QuerySnapshot<Map<String, dynamic>>> firestore;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 15),
// //       child: GridView(
// //         semanticChildCount: 4,
// //         gridDelegate:
// //             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
// //         children: [
// //           GridTile(
// //               child: Container(
// //             height: 180,
// //             width: 160,
// //             decoration: const BoxDecoration(
// //                 // color: Colors.red,
// //                 image: DecorationImage(
// //                     image: AssetImage("Assets/home_page/tshirt.png"))),
// //           )),
// //           GridTile(
// //               child: Container(
// //             height: 180,
// //             width: 160,
// //             decoration: const BoxDecoration(
// //                 // color: Colors.red,
// //                 image: DecorationImage(
// //                     image: AssetImage("Assets/home_page/tshirt.png"))),
// //           )),
// //           GridTile(
// //               child: Container(
// //             height: 180,
// //             width: 160,
// //             decoration: const BoxDecoration(
// //                 // color: Colors.red,
// //                 image: DecorationImage(
// //                     image: AssetImage("Assets/home_page/tshirt.png"))),
// //           )),
// //           GridTile(
// //               child: Container(
// //             height: 180,
// //             width: 160,
// //             decoration: const BoxDecoration(
// //                 // color: Colors.red,
// //                 image: DecorationImage(
// //                     image: AssetImage("Assets/home_page/tshirt.png"))),
// //           )),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class MainPageProductsCarouselSlider extends StatelessWidget {
// //   const MainPageProductsCarouselSlider({
// //     super.key,
// //     required this.firestore,
// //   });

// //   final Stream<QuerySnapshot<Map<String, dynamic>>> firestore;

// //   @override
// //   Widget build(BuildContext context) {
// //     dynamic productId;
// //     dynamic productName;
// //     // dynamic productPrice;
// //     dynamic imageUrlList;
// //     dynamic color;
// //     dynamic brand;
// //     dynamic price;
// //     dynamic gender;
// //     dynamic category;
// //     dynamic time;

// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 15),
// //       child: SizedBox(
// //         height: 300,
// //         child: StreamBuilder(
// //           stream: firestore,
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return const Center(
// //                 child: CircularProgressIndicator(),
// //               );
// //             }

// //             List<DocumentSnapshot> products = snapshot.data!.docs;
// //             products.shuffle();

// //             return CarouselSlider.builder(
// //               itemCount: products.length < 4 ? products.length : 4,
// //               options: CarouselOptions(
// //                 viewportFraction: .6,
// //                 autoPlay: false,
// //                 enlargeCenterPage: true,
// //               ),
// //               itemBuilder: (context, index, _) {
// //                 productId = products[index]["id"];
// //                 productName = products[index]["name"];
// //                 // productPrice = products[index]["price"];
// //                 imageUrlList = products[index]["imageUrl"];
// //                 color = products[index]["color"];
// //                 brand = products[index]["brand"];
// //                 price = products[index]["price"];
// //                 gender = products[index]["gender"];
// //                 category = products[index]["category"];
// //                 time = products[index]["time"];
// //                 List size = products[index]["size"];
// //                 return InkWell(
// //                   onTap: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => ProductDetailPage(
// //                           productId: productId,
// //                           productName: productName,
// //                           imageUrl: imageUrlList,
// //                           color: color,
// //                           brand: brand,
// //                           price: price,
// //                           size: size,
// //                           category: category,
// //                           gender: gender,
// //                           time: time,
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                   child: SizedBox(
// //                     height: 450,
// //                     width: 250,
// //                     child: Row(
// //                       children: [
// //                         Image.network(
// //                           imageUrlList[0],
// //                           fit: BoxFit.fill,
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                   // mainPageView(
// //                   //   brand: brand,
// //                   //   category: category,
// //                   //   gender: gender,
// //                   //   time: time,
// //                   //   productId: productId,
// //                   //   index: index,
// //                   //   productName: productName,
// //                   //   imageUrl: imageUrlList[0],
// //                   //   productPrice: productPrice,
// //                   // ),
// //                 );
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// // Widget mainPageHeading(String text) {
// //   return Text(
// //     text.toUpperCase(),
// //     style: const TextStyle(
// //       letterSpacing: 3,
// //       fontSize: 15,
// //       fontWeight: FontWeight.w500,
// //     ),
// //   );
// // }

// // Widget mainPageCircularAvatar({
// //   required double screenWidth,
// //   required String name,
// // }) {
// //   return CircleAvatar(
// //     radius: screenWidth * .15,
// //     backgroundColor: Colors.grey.shade200,
// //     child: Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Text(
// //             name,
// //             style: TextStyle(
// //                 fontWeight: FontWeight.bold,
// //                 letterSpacing: 2,
// //                 color: Colors.blueGrey.shade800),
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }

// // TextStyle customTextStyle() {
// //   return const TextStyle(
// //     letterSpacing: 1,
// //     fontSize: 15,
// //     fontWeight: FontWeight.w500,
// //   );
// // }

// // FavoriteBloc favoriteBloc = FavoriteBloc();
// // FavoriteRepository favoriteRepository = FavoriteRepository();

// // Widget mainPageView(
// //     {required String productName,
// //     required String productPrice,
// //     required String imageUrl,
// //     required int index,
// //     required String productId,
// //     required String time,
// //     required String gender,
// //     required String category,
// //     required String brand}) {
// //   return Center(
// //     child: Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Stack(
// //           children: [
// //             Container(
// //               // color: Colors.red,
// //               height: 180,
// //               width: 160,
// //               decoration: BoxDecoration(
// //                   // color: Colors.amber,
// //                   borderRadius: BorderRadius.circular(30)),
// //               child: ClipRRect(
// //                 borderRadius: BorderRadius.circular(15),
// //                 child: Image.network(
// //                   imageUrl,
// //                   fit: BoxFit.cover,
// //                   loadingBuilder: (context, child, loadingProgress) {
// //                     if (loadingProgress == null) {
// //                       return child;
// //                     } else {
// //                       return const Center(
// //                         child: CircularProgressIndicator(),
// //                       );
// //                     }
// //                   },
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         Container(
// //           width: 160,
// //           height: 60,
// //           padding: const EdgeInsets.all(10),
// //           // color: Colors.red,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Expanded(
// //                 child: Text(productName.toUpperCase(),
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: customTextStyle()),
// //               ),
// //               Text("₹$productPrice/-", style: customTextStyle())
// //             ],
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }

// // class MainPageCarouselSlider extends StatelessWidget {
// //   const MainPageCarouselSlider({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return CarouselSlider(
// //       items: [
// //         {'imagePath': 'Assets/Images/BAnner_grande.webp', 'text': 'T-shirts'},
// //         {'imagePath': 'Assets/Images/images.jpg', 'text': 'Shirts'},
// //       ].map((item) {
// //         return Builder(
// //           builder: (BuildContext context) {
// //             return Container(
// //               width: MediaQuery.of(context).size.width,
// //               margin: const EdgeInsets.symmetric(horizontal: 5.0),
// //               decoration: BoxDecoration(
// //                 color: Colors.grey.shade300,
// //                 borderRadius: const BorderRadius.all(Radius.circular(20)),
// //               ),
// //               child: InkWell(
// //                 onTap: () {},
// //                 child: Stack(
// //                   fit: StackFit.expand,
// //                   children: [
// //                     ClipRRect(
// //                       borderRadius: const BorderRadius.all(Radius.circular(20)),
// //                       child: Image.asset(
// //                         item['imagePath']!,
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                     // Positioned(
// //                     //   child: Container(
// //                     //     padding: const EdgeInsets.all(10),
// //                     //     child: Center(
// //                     //       child: Text(
// //                     //         item['text']!,
// //                     //         style: const TextStyle(
// //                     //           color: Colors.white,
// //                     //           fontSize: 33,
// //                     //           fontWeight: FontWeight.bold,
// //                     //           letterSpacing: 3,
// //                     //         ),
// //                     //       ),
// //                     //     ),
// //                     //   ),
// //                     // ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       }).toList(),
// //       options: CarouselOptions(autoPlay: true, viewportFraction: 1),
// //     );
// //   }
// // }

// // class ExploreItemsInHomePage extends StatelessWidget {
// //   final List<ProductCategory> products;

// //   const ExploreItemsInHomePage({super.key, required this.products});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(10.0),
// //       child: GridView.builder(
// //         physics: const NeverScrollableScrollPhysics(),
// //         shrinkWrap: true,
// //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //           mainAxisSpacing: 20,
// //           crossAxisSpacing: 20,
// //           crossAxisCount: 2,
// //         ),
// //         itemCount: 4,
// //         itemBuilder: (context, index) {
// //           List<String> images = [
// //             "Assets/home_page/tshirts.png",
// //             "Assets/home_page/jeans.png",
// //             "Assets/home_page/sweatshirts.png",
// //             "Assets/home_page/shirts.png",
// //           ];
// //           return GestureDetector(
// //             onTap: () {
// //               if (index == 0) {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => ProductsCategoryInExplore(
// //                       productList: products,
// //                     ),
// //                   ),
// //                 );
// //               } else if (index == 3) {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => ProductsShirtInExplore(
// //                       productList: products,
// //                     ),
// //                   ),
// //                 );
// //               }
// //             },
// //             child: GridTile(
// //               child: Container(
// //                 height: 100,
// //                 width: 100,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(15),
// //                   color: Colors.grey.shade200,
// //                   image: DecorationImage(
// //                     fit: BoxFit.cover,
// //                     image: AssetImage(images[index]),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// ////////////////////////////////////////////////(og code not saifu)
// import 'dart:async';
// import 'dart:io';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:tuni/core/provider/product_provider.dart';
// import 'package:tuni/presentation/bloc/favorite_bloc/favorite_repository.dart';
// import 'package:tuni/presentation/pages/Home/pages_in_home_page/product_detail_page.dart';
// import 'package:tuni/presentation/pages/Home/pages_in_home_page/products_category_page.dart';
// import 'package:tuni/presentation/pages/combo/combo.dart';
// import 'package:tuni/presentation/pages/combo/combo_detail_page.dart';
// import 'package:video_player/video_player.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../core/model/product_category_model.dart';
// import '../../bloc/favorite_bloc/favorite_bloc.dart';
// import '../caterory/pages_in_categories/category_all_page.dart';
// import '../caterory/pages_in_categories/category_kids_page.dart';
// import '../caterory/pages_in_categories/category_men_page.dart';
// import '../caterory/pages_in_categories/category_women_page.dart';
// import '../search/search_widget.dart';
// import 'pages_in_home_page/Shirt/Shirtcategory.dart';

// class MainPageSliverAppBar extends StatelessWidget {
//   const MainPageSliverAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       foregroundColor: Colors.black,
//       title: const Text(
//         'TUNi',
//         style: TextStyle(
//           letterSpacing: 8,
//           fontSize: 30,
//           fontWeight: FontWeight.w800,
//         ),
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const SearchScreen()),
//             );
//           },
//           icon: const Icon(
//             Icons.search,
//             size: 35,
//           ),
//         ),
//       ],
//       floating: true,
//       snap: true,
//       toolbarHeight: 80,
//     );
//   }
// }

// class MainPageFilterByCategory extends StatelessWidget {
//   const MainPageFilterByCategory({
//     super.key,
//     required this.screenWidth,
//     required this.screenHeight,
//   });

//   final double screenWidth;
//   final double screenHeight;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: screenWidth,
//         height: screenHeight * .42,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AllCategory(),
//                         ));
//                   },
//                   child: mainPageCircularAvatar(
//                       screenWidth: screenWidth, name: 'ALL'),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MenCategory(),
//                         ));
//                   },
//                   child: mainPageCircularAvatar(
//                       screenWidth: screenWidth, name: 'MEN'),
//                 )
//               ],
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => WomenCategory(),
//                         ));
//                   },
//                   child: mainPageCircularAvatar(
//                       screenWidth: screenWidth, name: 'WOMEN'),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => KidsCategory(),
//                         ));
//                   },
//                   child: mainPageCircularAvatar(
//                       screenWidth: screenWidth, name: 'KIDS'),
//                 )
//               ],
//             ),
//           ],
//         ));
//   }
// }

// class MainPageSeeMoreTextButton extends StatelessWidget {
//   final List<ProductCategory> allProductList;
//   const MainPageSeeMoreTextButton({
//     required this.allProductList,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AllCategory(
//                   allProductList: allProductList,
//                 ),
//               ));
//         },
//         child: const Text(
//           'view all',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ));
//   }
// }

// class MainPageGridViewProductList extends StatelessWidget {
//   const MainPageGridViewProductList({
//     super.key,
//     // required this.firestore,
//   });

//   // final Stream<QuerySnapshot<Map<String, dynamic>>> firestore;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: GridView(
//         semanticChildCount: 4,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         children: [
//           GridTile(
//               child: Container(
//             height: 180,
//             width: 160,
//             decoration: const BoxDecoration(
//                 // color: Colors.red,
//                 image: DecorationImage(
//                     image: AssetImage("Assets/home_page/tshirt.png"))),
//           )),
//           GridTile(
//               child: Container(
//             height: 180,
//             width: 160,
//             decoration: const BoxDecoration(
//                 // color: Colors.red,
//                 image: DecorationImage(
//                     image: AssetImage("Assets/home_page/tshirt.png"))),
//           )),
//           GridTile(
//               child: Container(
//             height: 180,
//             width: 160,
//             decoration: const BoxDecoration(
//                 // color: Colors.red,
//                 image: DecorationImage(
//                     image: AssetImage("Assets/home_page/tshirt.png"))),
//           )),
//           GridTile(
//               child: Container(
//             height: 180,
//             width: 160,
//             decoration: const BoxDecoration(
//                 // color: Colors.red,
//                 image: DecorationImage(
//                     image: AssetImage("Assets/home_page/tshirt.png"))),
//           )),
//         ],
//       ),
//     );
//   }
// }

// class MainPageProductsCarouselSlider extends StatelessWidget {
//   const MainPageProductsCarouselSlider({
//     super.key,
//     required this.firestore,
//   });

//   final Stream<QuerySnapshot<Map<String, dynamic>>> firestore;

//   @override
//   Widget build(BuildContext context) {
//     dynamic productId;
//     dynamic productName;
//     // dynamic productPrice;
//     dynamic imageUrlList;
//     dynamic color;
//     dynamic brand;
//     dynamic price;
//     dynamic gender;
//     dynamic category;
//     dynamic time;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: SizedBox(
//         height: 300,
//         child: StreamBuilder(
//           stream: firestore,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             List<DocumentSnapshot> products = snapshot.data!.docs;
//             products.shuffle();

//             return CarouselSlider.builder(
//               itemCount: products.length < 4 ? products.length : 4,
//               options: CarouselOptions(
//                 viewportFraction: .6,
//                 autoPlay: false,
//                 enlargeCenterPage: true,
//               ),
//               itemBuilder: (context, index, _) {
//                 productId = products[index]["id"];
//                 productName = products[index]["name"];
//                 // productPrice = products[index]["price"];
//                 imageUrlList = products[index]["imageUrl"];
//                 color = products[index]["color"];
//                 brand = products[index]["brand"];
//                 price = products[index]["price"];
//                 gender = products[index]["gender"];
//                 category = products[index]["category"];
//                 time = products[index]["time"];
//                 List size = products[index]["size"];
//                 return InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProductDetailPage(
//                           productId: productId,
//                           productName: productName,
//                           imageUrl: imageUrlList,
//                           color: color,
//                           brand: brand,
//                           price: price,
//                           size: size,
//                           category: category,
//                           gender: gender,
//                           time: time,
//                         ),
//                       ),
//                     );
//                   },
//                   child: SizedBox(
//                     height: 450,
//                     width: 250,
//                     child: Row(
//                       children: [
//                         Image.network(
//                           imageUrlList[0],
//                           fit: BoxFit.fill,
//                         )
//                       ],
//                     ),
//                   ),
//                   // mainPageView(
//                   //   brand: brand,
//                   //   category: category,
//                   //   gender: gender,
//                   //   time: time,
//                   //   productId: productId,
//                   //   index: index,
//                   //   productName: productName,
//                   //   imageUrl: imageUrlList[0],
//                   //   productPrice: productPrice,
//                   // ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// Widget mainPageHeading(String text) {
//   return Text(
//     text.toUpperCase(),
//     style: const TextStyle(
//       letterSpacing: 3,
//       fontSize: 15,
//       fontWeight: FontWeight.bold,
//     ),
//   );
// }

// Widget mainPageCircularAvatar({
//   required double screenWidth,
//   required String name,
// }) {
//   return CircleAvatar(
//     radius: screenWidth * .15,
//     backgroundColor: Colors.grey.shade200,
//     child: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             name,
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 2,
//                 color: Colors.blueGrey.shade800),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// TextStyle customTextStyle() {
//   return const TextStyle(
//     letterSpacing: 1,
//     fontSize: 15,
//     fontWeight: FontWeight.w500,
//   );
// }

// FavoriteBloc favoriteBloc = FavoriteBloc();
// FavoriteRepository favoriteRepository = FavoriteRepository();

// Widget mainPageView(
//     {required String productName,
//     required String productPrice,
//     required String imageUrl,
//     required int index,
//     required String productId,
//     required String time,
//     required String gender,
//     required String category,
//     required String brand}) {
//   return Center(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(
//           children: [
//             Container(
//               // color: Colors.red,
//               height: 180,
//               width: 160,
//               decoration: BoxDecoration(
//                   // color: Colors.amber,
//                   borderRadius: BorderRadius.circular(30)),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) {
//                       return child;
//                     } else {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Container(
//           width: 160,
//           height: 60,
//           padding: const EdgeInsets.all(10),
//           // color: Colors.red,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Text(productName.toUpperCase(),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: customTextStyle()),
//               ),
//               Text("₹$productPrice/-", style: customTextStyle())
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// // class MainPageCarouselSlider extends StatefulWidget {
// //   const MainPageCarouselSlider({Key? key}) : super(key: key);

// //   @override
// //   _MainPageCarouselSliderState createState() => _MainPageCarouselSliderState();
// // }

// // class _MainPageCarouselSliderState extends State<MainPageCarouselSlider> {
// //   late List<Map<String, dynamic>> carouselItems;
// //   late List<VideoPlayerController> controllers;

// //   @override
// //   void initState() {
// //     super.initState();

// //     // Replace with actual Firebase video URLs
// //     List<String> firebaseVideoPaths = [
// //       'https://firebasestorage.googleapis.com/v0/b/tunitest-e022d.appspot.com/o/Combo_videos%2FMens%20casual%20combo_1717590411458?alt=media&token=46796b19-1c60-4bbf-8113-f6b8a8eb4e99',
// //       'https://firebasestorage.googleapis.com/v0/b/tunitest-e022d.appspot.com/o/Combo_videos%2FMens%20casual%20combo_1717590411458?alt=media&token=46796b19-1c60-4bbf-8113-f6b8a8eb4e99',
// //       'https://firebasestorage.googleapis.com/v0/b/tunitest-e022d.appspot.com/o/Combo_videos%2FMens%20casual%20combo_1717590411458?alt=media&token=46796b19-1c60-4bbf-8113-f6b8a8eb4e99',
// //     ];

// //     carouselItems = firebaseVideoPaths.map((path) {
// //       return {'videoPath': path, 'text': 'Video Title'};
// //     }).toList();

// //     controllers = carouselItems.map((item) {
// //       return _initializeVideoPlayer(item['videoPath']);
// //     }).toList();
// //   }

// //   @override
// //   void dispose() {
// //     controllers.forEach((controller) {
// //       controller.pause();
// //       controller.dispose();
// //     });
// //     super.dispose();
// //   }

// //   VideoPlayerController _initializeVideoPlayer(String videoPath) {
// //     VideoPlayerController controller = VideoPlayerController.network(videoPath);
// //     controller.initialize().then((_) {
// //       setState(() {}); // Ensure the video initializes before playing
// //       controller.setLooping(true); // Set looping to true so it repeats
// //       controller.play(); // Autoplay the video
// //     }).catchError((error) {
// //       print('Error initializing video player: $error');
// //     });
// //     return controller;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return CarouselSlider(
// //       items: carouselItems.map((item) {
// //         int index = carouselItems.indexOf(item);
// //         return Builder(
// //           builder: (BuildContext context) {
// //             return Container(
// //               width: MediaQuery.of(context).size.width,
// //               margin: const EdgeInsets.symmetric(horizontal: 5.0),
// //               decoration: BoxDecoration(
// //                 color: Colors.grey.shade300,
// //                 borderRadius: const BorderRadius.all(Radius.circular(20)),
// //               ),
// //               child: Stack(
// //                 fit: StackFit.expand,
// //                 children: [
// //                   ClipRRect(
// //                     borderRadius: const BorderRadius.all(Radius.circular(20)),
// //                     child: AspectRatio(
// //                       aspectRatio: 16 /
// //                           9, // Adjust aspect ratio as per your video dimensions
// //                       child: controllers[index].value.isInitialized
// //                           ? VideoPlayer(controllers[index])
// //                           : Center(
// //                               child:
// //                                   CircularProgressIndicator()), // Placeholder or loading indicator
// //                     ),
// //                   ),
// //                   // Optional: Overlay text
// //                   Positioned(
// //                     bottom: 10,
// //                     left: 10,
// //                     child: Text(
// //                       item['text'] ?? '',
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //         );
// //       }).toList(),
// //       options: CarouselOptions(
// //         autoPlay: true,
// //         viewportFraction: 1,
// //       ),
// //     );
// //   }
// // }
// class MainPageCarouselSlider extends StatelessWidget {
//   const MainPageCarouselSlider({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       items: [
//         {'imagePath': 'Assets/Images/BAnner_grande.webp', 'text': 'T-shirts'},
//         {'imagePath': 'Assets/Images/images.jpg', 'text': 'Shirts'},
//       ].map((item) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               margin: const EdgeInsets.symmetric(horizontal: 5.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: const BorderRadius.all(Radius.circular(20)),
//               ),
//               child: InkWell(
//                 onTap: () {},
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(20)),
//                       child: Image.asset(
//                         item['imagePath']!,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     // Positioned(
//                     //   child: Container(
//                     //     padding: const EdgeInsets.all(10),
//                     //     child: Center(
//                     //       child: Text(
//                     //         item['text']!,
//                     //         style: const TextStyle(
//                     //           color: Colors.white,
//                     //           fontSize: 33,
//                     //           fontWeight: FontWeight.bold,
//                     //           letterSpacing: 3,
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//       options: CarouselOptions(autoPlay: true, viewportFraction: 1),
//     );
//   }
// }

// class ExploreItemsInHomePage extends StatelessWidget {
//   final List<ProductCategory> products;

//   const ExploreItemsInHomePage({super.key, required this.products});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           mainAxisSpacing: 20,
//           crossAxisSpacing: 20,
//           crossAxisCount: 2,
//         ),
//         itemCount: 4,
//         itemBuilder: (context, index) {
//           List<String> images = [
//             "Assets/home_page/tshirts.png",
//             "Assets/home_page/jeans.png",
//             "Assets/home_page/sweatshirts.png",
//             "Assets/home_page/shirts.png",
//           ];
//           return GestureDetector(
//             onTap: () {
//               if (index == 0) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ProductsCategoryInExplore(
//                       productList: products,
//                     ),
//                   ),
//                 );
//               } else if (index == 3) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ProductsShirtInExplore(
//                       productList: products,
//                     ),
//                   ),
//                 );
//               }
//             },
//             child: GridTile(
//               child: Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.grey.shade200,
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(images[index]),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // product slider

// class ProductSlider extends StatelessWidget {
//   final double screenWidth;
//   final List<ProductCategory> productList;

//   const ProductSlider({
//     Key? key,
//     required this.screenWidth,
//     required this.productList,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double itemWidth = (screenWidth - 32) / 3;

//     return SizedBox(
//       height: 600,
//       child: GridView.builder(
//         physics: ScrollPhysics(), // Use default physics to allow scrolling
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//           childAspectRatio: 1,
//         ),
//         itemCount: productList.length > 6 ? 6 : productList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   // builder: (context) => ProductsCategoryInExplore(
//                   //   productList: productList,
//                   // ),

//                   //other method inside direct page

//                    builder: (context) => ProductDetailPage(
//                      productId:productList[index].price,
//                      productName: productList[index].name,
//                      imageUrl:productList[index].imageUrlList,
//                      color: productList[index].color,
//                      brand: productList[index].brand,
//                      price:productList[index].price,
//                      size: productList[index].size,
//                      gender: productList[index].gender,
//                      category: productList[index].price,
//                      time: productList[index].time,
//                     ),
//                 ),
//               );
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.0),
//                 color: Colors.grey[200],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8.0),
//                 child: Image.network(
//                   productList[index].imageUrlList[0],
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Function to truncate text and add '...' if longer than maxLength
// String _truncateText(String text, int maxLength) {
//   if (text.length <= maxLength) {
//     return text;
//   } else {
//     return text.substring(0, maxLength) + '...';
//   }
// }

// // home page color gradient feature container.
// class GradientContainer extends StatelessWidget {
//   final Widget child;
//   final List<Color> colors;
//   final Alignment begin;
//   final Alignment end;
//   final double borderRadius;
//   final EdgeInsets padding;

//   const GradientContainer({
//     Key? key,
//     required this.child,
//     required this.colors,
//     this.begin = Alignment.topCenter,
//     this.end = Alignment.bottomCenter,
//     this.borderRadius = 0.0,
//     this.padding = EdgeInsets.zero,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: padding,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: colors,
//           begin: begin,
//           end: end,
//           stops: const [0.0, 0.7],
//           tileMode: TileMode.clamp,
//         ),
//         borderRadius: BorderRadius.circular(borderRadius),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }
// }

// //combo grid in home page
// class ImageGridWidget extends StatefulWidget {
//   final List<ComboDetailPage> productList1;

//   const ImageGridWidget({
//     Key? key,
//     required this.productList1,
//   }) : super(key: key);

//   @override
//   _ImageGridWidgetState createState() => _ImageGridWidgetState();
// }

// class _ImageGridWidgetState extends State<ImageGridWidget> {
//   late ScrollController _scrollController;
//   Timer? _timer;
//   int _currentIndex = 0;
//   final int resetIndex = 13; // Reset index threshold

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _startAutoScroll();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   void _startAutoScroll() {
//     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
//       if (_currentIndex < widget.productList1.length - 1) {
//         _currentIndex++;
//       } else {
//         _currentIndex = 0;
//       }
//       _scrollToIndex(_currentIndex);
//     });
//   }

//   void _scrollToIndex(int index) {
//     double maxScrollExtent = (widget.productList1.length - 2) *
//         MediaQuery.of(context).size.width /
//         2;

//     double scrollOffset = index * MediaQuery.of(context).size.width / 2;

//     if (_currentIndex >= 6) {
//       _scrollController.animateTo(
//         0,
//         duration: Duration(milliseconds: 1000),
//         curve: Curves.easeInOut,
//       );
//     } else if (scrollOffset <= maxScrollExtent) {
//       _scrollController.animateTo(
//         scrollOffset,
//         duration: Duration(milliseconds: 1000),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       controller: _scrollController,
//       child: Row(
//         children: List.generate(widget.productList1.length, (index) {
//           return Container(
//             width: MediaQuery.of(context).size.width / 2, // 2 columns per page
//             child: Column(
//               children: List.generate(2, (rowIndex) {
//                 int itemIndex = index * 2 + rowIndex;
//                 if (itemIndex < widget.productList1.length) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => ComboPage()
//     // ComboDetailPage(
//     //   comboId: widget.productList1[index].comboId ,
//     //   brand: widget.productList1[index].brand ,
//     //   comboType: widget.productList1[index].comboType ,
//     //   comboName: widget.productList1[index].comboName ,
//     //   comboDescription: widget.productList1[index].comboDescription ,
//     //   comboPrice: widget.productList1[index].comboPrice,
//     //   comboQuantity: widget.productList1[index].comboQuantity ,
//     //   timestamp: widget.productList1[index].timestamp,
//     //   comboCount: widget.productList1[index].comboCount,
//     //   comboCategory: widget.productList1[index].comboCategory ,
//     //   itemsInCombo: widget.productList1[index].itemsInCombo,
//     //         thumbnailImageAndVideo: widget.productList1[index].thumbnailImageAndVideo,

//     //   thumbnailImage: widget.productList1[index].thumbnailImage ,
//     //         thumbnailVideo: widget.productList1[index].thumbnailVideo,

//     // ),
//   ),
// );

//                     },
//                     child: AspectRatio(
//                       aspectRatio:
//                           0.7, // Maintain aspect ratio (adjust as needed)
//                       child: Container(
//                         margin: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12.0),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(12.0),
//                           child: Image.network(
//                             widget.productList1[itemIndex].thumbnailImage,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return SizedBox.shrink(); // Placeholder for empty space
//                 }
//               }),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// //combo saifu code
// class MainPageComboListing extends StatelessWidget {
//   MainPageComboListing({
//     Key? key,
//     required this.screenWidth,
//     required this.screenHeight,
//   }) : super(key: key);

//   final double screenWidth;
//   final double screenHeight;

//   final firestore = FirebaseFirestore.instance.collection("combo_products").snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: firestore,
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return SizedBox(
//             height: screenHeight * 0.355,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 3,
//               itemBuilder: (context, index) {
//                 return Shimmer.fromColors(
//                   baseColor: Colors.grey[300]!,
//                   highlightColor: Colors.grey[100]!,
//                   child: Container(
//                     width: 200,
//                     margin: const EdgeInsets.symmetric(horizontal: 10),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[400],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         }

//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }

//         return SizedBox(
//           height: screenHeight * 0.355,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var document = snapshot.data!.docs[index];
//               String comboId = document['id'];
//               String brand = document['brand'];
//               String comboType = document['combotype'];
//               String comboName = document['name'];
//               String comboDescription = document['description'];
//               String comboPrice = document['price'];
//               String comboQuantity = document['quantity'];
//               Timestamp timeStamp = document['timestamp'];
//               String comboCountString = document['combo_count'];
//               int comboCount = int.parse(comboCountString[0]);
//               String comboCategory = document['gender'];
//               List<dynamic> itemsInCombo = document["combo_details"];
//               String thumbnailImage = document['tumbnail'];
//               String thumbnailVideo = document['videoUrl'];
//               List<Map<String, dynamic>> thumbnailImageAndVideo = [
//                 {
//                   "id": "thumbnailImage",
//                   "name": comboName,
//                   "description": comboDescription,
//                   "url": thumbnailImage
//                 },
//               ];

//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ComboDetailPage(
//                         comboId: comboId,
//                         brand: brand,
//                         comboType: comboType,
//                         comboName: comboName,
//                         comboDescription: comboDescription,
//                         comboPrice: comboPrice,
//                         comboQuantity: comboQuantity,
//                         timestamp: timeStamp,
//                         comboCount: comboCount,
//                         comboCategory: comboCategory,
//                         itemsInCombo: itemsInCombo,
//                         thumbnailImage: thumbnailImage,
//                         thumbnailVideo: thumbnailVideo,
//                         thumbnailImageAndVideo: thumbnailImageAndVideo,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: 200,
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: NetworkImage(thumbnailImage),
//                     ),
//                     color: Colors.grey[400],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Center(
//                     child: Text(
//                       comboName,
//                       style: TextStyle(
//                         color: Colors.white,
//                         backgroundColor: Colors.black54,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
// //marquee widget

// class MarqueeText extends StatefulWidget {
//   final String text;
//   final TextStyle? style;
//   final double velocity;
//   final double gap;

//   const MarqueeText({
//     Key? key,
//     required this.text,
//     this.style,
//     this.velocity = 50.0,
//     this.gap = 50.0,
//   }) : super(key: key);

//   @override
//   _MarqueeTextState createState() => _MarqueeTextState();
// }

// class _MarqueeTextState extends State<MarqueeText> {
//   late ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController(initialScrollOffset: widget.gap);
//     _scroll();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scroll() {
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: Duration(milliseconds: (widget.velocity * 1000 / 2).round()),
//       curve: Curves.linear,
//     );

//     Future.delayed(Duration(milliseconds: widget.velocity.toInt()), () {
//       if (mounted) {
//         _scrollController.jumpTo(widget.gap);
//         _scroll();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       controller: _scrollController,
//       child: Text(
//         widget.text,
//         style: widget.style,
//       ),
//     );
//   }
// }

// //mainpagecourolser1
// class MainPageCarouselSlider1 extends StatelessWidget {
//   const MainPageCarouselSlider1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       items: [
//         {'imagePath': 'Assets/home_page/pexels-cherubs-27025851.jpg'},
//         {'imagePath': 'Assets/home_page/pexels-ogproductionz-17243573.jpg'},
//         {'imagePath': 'Assets/home_page/pexels-cxpturing-souls-1377266-3054980.jpg'},
//         {'imagePath': 'Assets/home_page/banner1.jpg'},
//       ].map((item) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               margin: const EdgeInsets.symmetric(horizontal: 5.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: const BorderRadius.all(Radius.circular(20)),
//               ),
//               child: InkWell(
//                 onTap: () {},
//                 child: Stack(
//                   fit: StackFit.passthrough,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(0)),
//                       child: Image.asset(
//                         item['imagePath']!,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//       options: CarouselOptions(
//           autoPlay: true, viewportFraction: 1, aspectRatio: 0.8),
//     );
//   }
// }

// // og code ends

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Import Flutter material library for Android
import 'package:shimmer/shimmer.dart';
import 'package:tuni/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:tuni/presentation/bloc/favorite_bloc/favorite_repository.dart';
import 'package:tuni/presentation/pages/Home/explore/shirts/shirts_in_explore.dart';
import 'package:tuni/presentation/pages/Home/explore/tshirts/tshirts_in_explore.dart';
import '../combo/combo.dart';
import '../combo/combo_detail_page.dart';
import '../search/search_widget.dart';

class ViewAllButton extends StatelessWidget {
  final Type className;

  const ViewAllButton({
    Key? key,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // Replace CupertinoButton with TextButton for Android
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _getPageWidget(),
          ),
        );
      },
      child: Text(
        "View all",
        style: TextStyle(fontSize: 13),
      ),
    );
  }

  Widget _getPageWidget() {
    if (className == ComboPage) {
      return ComboPage();
    } else if (className == TShirtsInExplore) {
      return const TShirtsInExplore();
    } else if (className == ShirtsInExplore) {
      return const ShirtsInExplore();
    }
    throw Exception('Page not implemented for $className');
  }
}

class MainPageSliverAppBar extends StatelessWidget {
  const MainPageSliverAppBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text(
        'TUNi',
        style: TextStyle(
          letterSpacing: 8,
          fontSize: 30,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
          icon: const Icon(
            Icons.search,
            size: 35,
          ),
        ),
      ],
      floating: true,
      snap: true,
      toolbarHeight: 80,
    );
  }
}

class MainPageComboListing extends StatelessWidget {
  MainPageComboListing({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  final firestore =
      FirebaseFirestore.instance.collection("combo_products").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: screenHeight * 0.355,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return SizedBox(
          height: screenHeight * 0.355,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              String comboId = document['id'];
              String brand = document['brand'];
              String comboType = document['combotype'];
              String comboName = document['name'];
              String comboDescription = document['description'];
              String comboPrice = document['price'];
              String comboQuantity = document['quantity'];
              Timestamp timeStamp = document['timestamp'];
              String comboCountString = document['combo_count'];
              int comboCount = int.parse(comboCountString[0]);
              String comboCategory = document['gender'];
              List<dynamic> itemsInCombo = document["combo_details"];
              String thumbnailImage = document['tumbnail'];
              String thumbnailVideo = document['videoUrl'];
              List<Map<String, dynamic>> thumbnailImageAndVideo = [
                {
                  "id": "thumbnailImage",
                  "name": comboName,
                  "description": comboDescription,
                  "url": thumbnailImage
                },
              ];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComboDetailPage(
                        comboId: comboId,
                        brand: brand,
                        comboType: comboType,
                        comboName: comboName,
                        comboDescription: comboDescription,
                        comboPrice: comboPrice,
                        comboQuantity: comboQuantity,
                        timestamp: timeStamp,
                        comboCount: comboCount,
                        comboCategory: comboCategory,
                        itemsInCombo: itemsInCombo,
                        thumbnailImage: thumbnailImage,
                        thumbnailVideo: thumbnailVideo,
                        thumbnailImageAndVideo: thumbnailImageAndVideo,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(thumbnailImage),
                    ),
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // child: Center(
                  //   // child: Text(
                  //   //   comboName,
                  //   //   style: TextStyle(
                  //   //     color: Colors.white,
                  //   //     backgroundColor: Colors.black54,
                  //   //   ),
                  //   // ),
                  // ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

Widget mainPageHeading(String text) {
  return Text(
    text.toUpperCase(),
    style: TextStyle(
      letterSpacing: 3,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
  );
}

TextStyle customTextStyle() {
  return TextStyle(
    letterSpacing: 1,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
}

FavoriteBloc favoriteBloc = FavoriteBloc();
FavoriteRepository favoriteRepository = FavoriteRepository();

class MainPageCarouselSlider extends StatelessWidget {
  const MainPageCarouselSlider({Key? key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        {'imagePath': 'Assets/home_page/banner1.jpg'},
        {'imagePath': 'Assets/home_page/banner3.jpeg'},
        {'imagePath': 'Assets/home_page/banner2.jpg'},
        {'imagePath': 'Assets/home_page/banner4.jpg'},
      ].map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: InkWell(
                onTap: () {},
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(0)),
                      child: Image.asset(
                        item['imagePath']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        aspectRatio: 0.8,
      ),
    );
  }
}
