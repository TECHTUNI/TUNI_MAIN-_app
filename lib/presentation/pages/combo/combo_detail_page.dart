// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
// import 'package:tuni/core/provider/combo_provider.dart';
// import '../../../../core/model/combo_model.dart';
// import 'combo_refactor.dart';

// class ComboDetailPage extends StatefulWidget {
//   final String comboId;
//   final String brand;
//   final String comboType;
//   final String comboName;
//   final String comboDescription;
//   final String comboPrice;
//   final String comboQuantity;
//   final Timestamp timestamp;
//   final int comboCount;
//   final String comboCategory;
//   final List<dynamic> itemsInCombo;
//   final String thumbnailImage;
//   final String thumbnailVideo;
//   final List<Map<String, dynamic>> thumbnailImageAndVideo;

//   const ComboDetailPage({
//     super.key,
//     required this.comboId,
//     required this.brand,
//     required this.comboType,
//     required this.comboName,
//     required this.comboDescription,
//     required this.comboPrice,
//     required this.comboQuantity,
//     required this.timestamp,
//     required this.comboCount,
//     required this.comboCategory,
//     required this.itemsInCombo,
//     required this.thumbnailImageAndVideo,
//     required this.thumbnailImage,
//     required this.thumbnailVideo,
//   });

//   @override
//   State<ComboDetailPage> createState() => _ComboDetailPageState();
// }

// class _ComboDetailPageState extends State<ComboDetailPage> {
//   final List<String> shirtSizesList = ["XS", "S", "M", "L", "XL", "XXL"];
//   final List<String> pantSizesList = ["28", "30", "32", "34", "36", "38"];
//   final List<String> shoeSizesList = ["6", "7", "8", "9", "10", "11", "12"];
//   Map<int, String> selectedSizes = {};
//   List<ComboModel> comboList = [];
//   List<String> imageUrls = [];
//   List<ComboProductListModel> products = [];
//   int currentIndex = 0;
//   bool addedToCombo = false;
//   List<dynamic> combinedMediaList = [];
//   late int comboLengthForBuying;
//   Map<String, dynamic> productDetailsCombo = {};
//   final CarouselController _carouselController = CarouselController();

//   @override
//   void initState() {
//     comboLengthForBuying = widget.itemsInCombo.length == 6 ? 4 : 8;

//     super.initState();
//     products = fetchProducts(widget.itemsInCombo);
//     combinedMediaList = [...widget.thumbnailImageAndVideo, ...products];
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (products.isNotEmpty) {
//         Provider.of<SelectedProductProvider>(context, listen: false)
//             .setSelectedProduct(products[0]);
//       }
//     });

//     productDetailsCombo = {
//       "brand": widget.brand,
//       "combo_count": widget.comboCount,
//       "combo_details": widget.itemsInCombo,
//       "combotype": widget.comboType,
//       "description": widget.comboDescription,
//       "gender": widget.comboCategory,
//       "id": widget.comboId,
//       "name": widget.comboName,
//       "price": widget.comboPrice,
//       "quantity": widget.comboQuantity,
//       "timestamp": widget.timestamp,
//       "tumbnail": widget.thumbnailImage,
//       "videoUrl": widget.thumbnailVideo,

//       // "combo_details": widget.itemsInCombo.map((item) {
//       //   return {
//       //     "description": item.description,
//       //     "id": item.id,
//       //     "imageturls": item.imageturls,
//       //     "name": item.name,
//       //   };
//       // }).toList()
//     };
//   }
// //

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       // navigationBar: CupertinoNavigationBar(
//       //   middle: Text(widget.comboType),
//       //   backgroundColor: Colors.white,
//       //   border: null,
//       // ),
//       appBar: AppBar(
//         title: Text(widget.comboName),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CarouselSlider(
//                 items: combinedMediaList.map((item) {
//                   if (item is Map<String, dynamic> &&
//                       item['id'] == 'thumbnailVideo') {
//                     return VideoWidget(
//                       url: item['imageturls'],
//                       // controller: videoPlayerController
//                     );
//                   } else if (item is ComboProductListModel) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(10.0),
//                       child: Image.network(item.imageUrl, fit: BoxFit.cover),
//                     );
//                   } else {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(10.0),
//                       child: Image.network(item['url'], fit: BoxFit.cover),
//                     );
//                   }
//                 }).toList(),
//                 options: CarouselOptions(
//                   height: screenHeight * 0.41,
//                   viewportFraction: 0.7,
//                   enlargeCenterPage: true,
//                   initialPage: currentIndex,
//                   onPageChanged: (index, reason) {
//                     _updateButtonLabel(index);
//                   },
//                 ),
//                 carouselController: _carouselController,
//               ),
//               const SizedBox(height: 15),
//               const SizedBox(height: 15),
//               SizedBox(
//                 height: 50,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   children: List.generate(combinedMediaList.length, (index) {
//                     var item = combinedMediaList[index];
//                     String thumbnailUrl;
//                     if (item is Map<String, dynamic>) {
//                       thumbnailUrl = item['url'];
//                     } else if (item is ComboProductListModel) {
//                       thumbnailUrl = item.imageUrl;
//                     } else {
//                       thumbnailUrl = '';
//                     }
//                     return GestureDetector(
//                       // onTap: () {
//                       //   int carouselIndex = index + widget.thumbnailImageAndVideo.length;
//                       //   _updateButtonLabel(carouselIndex);
//                       // },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           border: Border.all(
//                             width: 3,
//                             color: currentIndex == index
//                                 ? Colors.green
//                                 : Colors.white,
//                           ),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(6.0),
//                           child: Image.network(
//                             thumbnailUrl,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Consumer<SelectedProductProvider>(
//                 builder: (context, selectedProductProvider, child) {
//                   ComboProductListModel? selectedProduct =
//                       selectedProductProvider.selectedProduct;
//                   if (currentIndex < widget.thumbnailImageAndVideo.length) {
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 10),
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.green.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Combo Details ",
//                               style:
//                                   TextStyle(fontSize: 13, letterSpacing: 0.5),
//                             ),
//                             Text(
//                               widget.comboName.toUpperCase(),
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 0.5,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Row(
//                               children: [
//                                 Text(
//                                   "₹${widget.comboPrice.toUpperCase()}/-",
//                                   style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       letterSpacing: 0.5,
//                                       color: Colors.red),
//                                 ),
//                                 const SizedBox(width: 15),
//                                 Text(
//                                   "₹${int.parse(widget.comboPrice) + 1501}/-",
//                                   style: const TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.w400,
//                                       letterSpacing: 0.5,
//                                       color: Colors.black,
//                                       decoration: TextDecoration.lineThrough),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             const Text(
//                               "Description: ",
//                               style:
//                                   TextStyle(fontSize: 13, letterSpacing: 0.5),
//                             ),
//                             Text(
//                               widget.comboDescription,
//                               style: const TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w500,
//                                 letterSpacing: 0.5,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     );
//                   } else if (selectedProduct == null) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   bool isVideoThumbnail =
//                       currentIndex < widget.thumbnailImageAndVideo.length &&
//                           widget.thumbnailImageAndVideo[currentIndex]['type'] ==
//                               'video';

//                   String selectedSizeLabel = selectedSizes.containsKey(
//                               currentIndex -
//                                   widget.thumbnailImageAndVideo.length) &&
//                           selectedSizes[currentIndex -
//                                   widget.thumbnailImageAndVideo.length]!
//                               .isNotEmpty
//                       ? "Selected Size: ${selectedSizes[currentIndex - widget.thumbnailImageAndVideo.length]}"
//                       : "Select Size";

//                   bool isAccessory =
//                       selectedProduct.name.toLowerCase().contains("accessory");

//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 10),
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.blue.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Product Details: ",
//                             style: TextStyle(fontSize: 13, letterSpacing: 0.5),
//                           ),
//                           Text(
//                             widget.comboName.toUpperCase(),
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           const Text(
//                             "Description: ",
//                             style: TextStyle(fontSize: 13, letterSpacing: 0.5),
//                           ),
//                           Text(
//                             selectedProduct.description,
//                             style: const TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                           if (!isVideoThumbnail && !isAccessory)
//                             const SizedBox(height: 10),
//                           if (!isVideoThumbnail && !isAccessory)
//                             TextButton(
//                               onPressed: () {
//                                 _showSizePicker(
//                                     context,
//                                     currentIndex -
//                                         widget.thumbnailImageAndVideo.length);
//                               },
//                               child: Text(
//                                 selectedSizeLabel,
//                                 style: const TextStyle(
//                                     fontSize: 16, color: Colors.blue),
//                               ),
//                             ),
//                           if (!isVideoThumbnail)
//                             addedToCombo
//                                 ? Padding(
//                                     padding: const EdgeInsets.only(top: 10.0),
//                                     child: Text(
//                                       'Item added to Combo'.toUpperCase(),
//                                       style: const TextStyle(
//                                         color: Colors.green,
//                                         fontSize: 18,
//                                         letterSpacing: 0.5,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   )
//                                 : ElevatedButton(
//                                     onPressed: () {
//                                       toggleCombo();
//                                     },
//                                     child: const Text(
//                                       'Add to Combo',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),
//               Visibility(
//                 visible: comboList.isNotEmpty,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Attention: 4 Products Mandatory! Your Combo Must Contain Exactly 4 Items. Adjust Accordingly. ⚠️",
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.red),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       'Combo Items:',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     ListView.builder(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: comboList.length,
//                       itemBuilder: (context, index) {
//                         // bool minComboLength =
//                         // comboList.length < 3 ? true : false;
//                         final comboItem = comboList[index];
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 60,
//                                     width: 50,
//                                     decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                             image:
//                                                 NetworkImage(comboItem.image),
//                                             fit: BoxFit.cover)),
//                                   ),
//                                   const SizedBox(width: 15),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       ComboAddedItems(
//                                           title: "Name",
//                                           text: comboItem.productName),
//                                       ComboAddedItems(
//                                           title: "Size",
//                                           text: comboItem.selectedSize),
//                                     ],
//                                   ),
//                                   const Spacer(),
//                                   ElevatedButton(
//                                       onPressed: () {
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             return AlertDialog(
//                                               title: const Text("Remove?"),
//                                               content: const Text(
//                                                   "This item will be removed from Selected Combo Products"),
//                                               actions: [
//                                                 TextButton(
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: const Text("Cancel"),
//                                                 ),
//                                                 TextButton(
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       comboList.removeAt(index);
//                                                     });
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: const Text(
//                                                     "Remove",
//                                                     style: TextStyle(
//                                                       color: Colors.red,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         );
//                                       },
//                                       child: const Icon(
//                                         Icons.delete,
//                                         color: Colors.red,
//                                         size: 17,
//                                       )),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 0),
//               Center(
//                 child: ElevatedButton(
//                     child: const Text("Add to Cart"),
//                     onPressed: () async {
//                       final userId = FirebaseAuth.instance.currentUser!.uid;
//                       if (comboList.length == comboLengthForBuying) {
//                         try {
//                           debugPrint(userId);

//                           List<Map<String, dynamic>> comboData =
//                               comboList.map((comboItem) {
//                             return {
//                               'productId': comboItem.productId,
//                               'productName': comboItem.productName,
//                               'selectedSize': comboItem.selectedSize,
//                               'image': comboItem.image,
//                               'description': comboItem.description,
//                             };
//                           }).toList();

//                           await FirebaseFirestore.instance
//                               .collection("users")
//                               .doc(userId)
//                               .collection("cartCollection_Combos")
//                               .add({
//                             'selectedItems': comboData,
//                             "itemCountcustomer": 1,
//                             "productDetailsCombo": productDetailsCombo
//                           }).then((value) {
//                             setState(() {
//                               comboList.clear();
//                               selectedSizes.clear();
//                             });
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title: Text("Success"),
//                                   content: Text(
//                                       "Combo has been successfully added to your cart."),
//                                   actions: [
//                                     TextButton(
//                                       child: Text("OK"),
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           }).catchError((error) {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title: Text("Error"),
//                                   content: Text(
//                                       "Failed to add combo to your cart. Please try again."),
//                                   actions: [
//                                     TextButton(
//                                       child: Text("OK"),
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           });

//                           debugPrint("Added to Firestore");
//                         } catch (e) {
//                           debugPrint("Failed to add to Firestore: $e");
//                         }
//                       } else {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: const Text("Hey there!"),
//                               content: Text(
//                                   "You can buy only $comboLengthForBuying items in combo!"),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text("OK"),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     }),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<ComboProductListModel> fetchProducts(List<dynamic> itemsInCombo) {
//     List<ComboProductListModel> products = [];
//     for (var item in itemsInCombo) {
//       if (item is Map<String, dynamic>) {
//         products.add(ComboProductListModel.fromMap(item));
//       }
//     }
//     return products;
//   }

//   // void _showSizePicker(BuildContext context, int productIndex) {
//   //   List<String> sizeList = pantSizesList;
//   //   if (products[productIndex].name.toLowerCase().contains("shoe")) {
//   //     sizeList = shoeSizesList;
//   //   } else if (!products[productIndex].name.toLowerCase().contains("jeans") &&
//   //       !products[productIndex].name.toLowerCase().contains("jean") &&
//   //       !products[productIndex].name.toLowerCase().contains("pants") &&
//   //       !products[productIndex].name.toLowerCase().contains("pant")) {
//   //     sizeList = shirtSizesList;
//   //   }

//   //   String initialSize = selectedSizes[productIndex] ?? sizeList[0];

//   //   void showCupertinoModalPopup(BuildContext context) {
//   //     showModalBottomSheet<void>(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return Container(
//   //           height: 216,
//   //           padding: const EdgeInsets.only(top: 6.0),
//   //           margin: EdgeInsets.only(
//   //             bottom: MediaQuery.of(context).viewInsets.bottom,
//   //           ),
//   //           color: Colors.white, // Use Colors.white or any Material color
//   //           child: SafeArea(
//   //             top: false,
//   //             child: ListWheelScrollView.useDelegate(
//   //               controller: FixedExtentScrollController(
//   //                 initialItem: sizeList.indexOf(initialSize),
//   //               ),
//   //               itemExtent: 32.0,
//   //               onSelectedItemChanged: (int selectedItem) {
//   //                 setState(() {
//   //                   selectedSizes[productIndex] = sizeList[selectedItem];
//   //                 });
//   //               },
//   //               childDelegate: ListWheelChildBuilderDelegate(
//   //                 builder: (context, index) {
//   //                   if (index >= 0 && index < sizeList.length) {
//   //                     return Center(
//   //                       child: Text(sizeList[index]),
//   //                     );
//   //                   }
//   //                   return null;
//   //                 },
//   //                 childCount: sizeList.length,
//   //               ),
//   //             ),
//   //           ),
//   //         );
//   //       },
//   //     );
//   //   }
//   // }
//   void _showSizePicker(BuildContext context, int productIndex) {
//     List<String> sizeList = pantSizesList;
//     if (products[productIndex].name.toLowerCase().contains("shoe")) {
//       sizeList = shoeSizesList;
//     } else if (!products[productIndex].name.toLowerCase().contains("jeans") &&
//         !products[productIndex].name.toLowerCase().contains("jean") &&
//         !products[productIndex].name.toLowerCase().contains("pants") &&
//         !products[productIndex].name.toLowerCase().contains("pant")) {
//       sizeList = shirtSizesList;
//     }

//     String initialSize = selectedSizes[productIndex] ?? sizeList[0];

//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Select Size'),
//           content: DropdownButton<String>(
//             value: initialSize,
//             onChanged: (String? newSize) {
//               if (newSize != null) {
//                 setState(() {
//                   selectedSizes[productIndex] = newSize;
//                 });
//                 Navigator.of(context).pop();
//               }
//             },
//             items: sizeList.map<DropdownMenuItem<String>>((String size) {
//               return DropdownMenuItem<String>(
//                 value: size,
//                 child: Text(size),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }

//   void toggleCombo() {
//     int productIndex = currentIndex - widget.thumbnailImageAndVideo.length;

//     if (productIndex >= 0) {
//       ComboProductListModel selectedProduct = products[productIndex];
//       bool isAccessory =
//           selectedProduct.name.toLowerCase().contains("accessory");

//       if (!isAccessory &&
//           (!selectedSizes.containsKey(productIndex) ||
//               selectedSizes[productIndex]!.isEmpty)) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text("Size Required"),
//               content:
//                   const Text("Please select a size before adding to combo."),
//               actions: [
//                 TextButton(
//                   child: const Text("OK"),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );

//         return;
//       }

//       setState(() {
//         if (addedToCombo) {
//           comboList
//               .removeWhere((combo) => combo.productId == selectedProduct.id);
//         } else {
//           bool productIdExists =
//               comboList.any((combo) => combo.productId == selectedProduct.id);
//           if (!productIdExists) {
//             comboList.add(ComboModel(
//               productId: selectedProduct.id,
//               productName: selectedProduct.name,
//               selectedSize: isAccessory
//                   ? "Not applicable"
//                   : selectedSizes[productIndex] ?? "Not selected",
//               image: selectedProduct.imageUrl,
//               description: selectedProduct.description,
//             ));
//           }
//         }

//         addedToCombo = !addedToCombo;
//       });
//     }
//   }

//   void _updateButtonLabel(int index) {
//     setState(() {
//       if (index >= widget.thumbnailImageAndVideo.length) {
//         int productIndex = index - widget.thumbnailImageAndVideo.length;
//         currentIndex = index;
//         Provider.of<SelectedProductProvider>(context, listen: false)
//             .setSelectedProduct(products[productIndex]);
//         addedToCombo = comboList.any(
//           (combo) => combo.productId == products[productIndex].id,
//         );
//       } else {
//         currentIndex = index;
//         Provider.of<SelectedProductProvider>(context, listen: false)
//             .setSelectedProduct(null);
//         addedToCombo = false;
//       }
//     });

//     _carouselController.animateToPage(
//       index,
//       // duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/provider/combo_provider.dart';
import 'package:tuni/presentation/pages/Cart/cart_page.dart';
import 'package:tuni/presentation/pages/auth/sign_up/refactor.dart';
import '../../../../core/model/combo_model.dart';
import 'combo_refactor.dart';

class ComboDetailPage extends StatefulWidget {
  final String comboId;
  final String brand;
  final String comboType;
  final String comboName;
  final String comboDescription;
  final String comboPrice;
  final String comboQuantity;
  final Timestamp timestamp;
  final int comboCount;
  final String comboCategory;
  final List<dynamic> itemsInCombo;
  final String thumbnailImage;
  final String thumbnailVideo;
  final List<Map<String, dynamic>>? thumbnailImageAndVideo;

  const ComboDetailPage({
    super.key,
    required this.comboId,
    required this.brand,
    required this.comboType,
    required this.comboName,
    required this.comboDescription,
    required this.comboPrice,
    required this.comboQuantity,
    required this.timestamp,
    required this.comboCount,
    required this.comboCategory,
    required this.itemsInCombo,
    this.thumbnailImageAndVideo,
    required this.thumbnailImage,
    required this.thumbnailVideo,
  });
  factory ComboDetailPage.fromJson(Map<String, dynamic> json) {
    return ComboDetailPage(
      comboId: json['id'] ?? '',
      brand: json['brand'] ?? '',
      comboType: json['comboType'] ?? '',
      comboName: json['name'] ?? '',
      comboDescription: json['comboDescription'] ?? '',
      comboPrice: json['price'] ?? '',
      comboQuantity: json['quantity'] ?? '',
      timestamp: json['timestamp'] ?? Timestamp.now(),
      comboCount: json['comboCount'] ?? 0,
      comboCategory: json['comboCategory'] ?? '',
      itemsInCombo: json['itemsInCombo'] ?? [],
      thumbnailImageAndVideo:
          List<Map<String, dynamic>>.from(json['thumbnailImageAndVideo'] ?? []),
      thumbnailImage: json['tumbnail'] ?? '',
      thumbnailVideo: json['videourl'] ?? '',
    );
  }

  @override
  State<ComboDetailPage> createState() => _ComboDetailPageState();
}

class _ComboDetailPageState extends State<ComboDetailPage> {
  final List<String> shirtSizesList = ["XS", "S", "M", "L", "XL", "XXL"];
  final List<String> pantSizesList = ["28", "30", "32", "34", "36", "38"];
  final List<String> shoeSizesList = ["6", "7", "8", "9", "10", "11", "12"];
  Map<int, String> selectedSizes = {};
  List<ComboModel> comboList = [];
  List<String> imageUrls = [];
  List<ComboProductListModel> products = [];
  int currentIndex = 0;
  bool addedToCombo = false;
  List<dynamic> combinedMediaList = [];
  late int comboLengthForBuying;
  Map<String, dynamic> productDetailsCombo = {};
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    comboLengthForBuying = widget.itemsInCombo.length == 6 ? 4 : 8;

    super.initState();
    products = fetchProducts(widget.itemsInCombo);
    combinedMediaList = [...?widget.thumbnailImageAndVideo, ...products];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (products.isNotEmpty) {
        Provider.of<SelectedProductProvider>(context, listen: false)
            .setSelectedProduct(products[0]);
      }
    });

    productDetailsCombo = {
      "brand": widget.brand,
      "combo_count": widget.comboCount,
      "combo_details": widget.itemsInCombo,
      "combotype": widget.comboType,
      "description": widget.comboDescription,
      "gender": widget.comboCategory,
      "id": widget.comboId,
      "name": widget.comboName,
      "price": widget.comboPrice,
      "quantity": widget.comboQuantity,
      "timestamp": widget.timestamp,
      "tumbnail": widget.thumbnailImage,
      "videoUrl": widget.thumbnailVideo,

      // "combo_details": widget.itemsInCombo.map((item) {
      //   return {
      //     "description": item.description,
      //     "id": item.id,
      //     "imageturls": item.imageturls,
      //     "name": item.name,
      //   };
      // }).toList()
    };
  }
//

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text(widget.comboType),
      //   backgroundColor: Colors.white,
      //   border: null,
      // ),
      appBar: AppBar(
        title: Text(widget.comboName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: combinedMediaList.map((item) {
                  if (item is Map<String, dynamic> &&
                      item['id'] == 'thumbnailVideo') {
                    return VideoWidget(
                      url: item['imageturls'],
                      // controller: videoPlayerController
                    );
                  } else if (item is ComboProductListModel) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(item.imageUrl, fit: BoxFit.cover),
                    );
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(item['url'], fit: BoxFit.cover),
                    );
                  }
                }).toList(),
                options: CarouselOptions(
                  height: screenHeight * 0.41,
                  viewportFraction: 0.7,
                  enlargeCenterPage: true,
                  initialPage: currentIndex,
                  onPageChanged: (index, reason) {
                    _updateButtonLabel(index);
                  },
                ),
                carouselController: _carouselController,
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: List.generate(combinedMediaList.length, (index) {
                    var item = combinedMediaList[index];
                    String thumbnailUrl;
                    if (item is Map<String, dynamic>) {
                      thumbnailUrl = item['url'];
                    } else if (item is ComboProductListModel) {
                      thumbnailUrl = item.imageUrl;
                    } else {
                      thumbnailUrl = '';
                    }
                    return GestureDetector(
                      // onTap: () {
                      //   int carouselIndex = index + widget.thumbnailImageAndVideo.length;
                      //   _updateButtonLabel(carouselIndex);
                      // },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 3,
                            color: currentIndex == index
                                ? Colors.green
                                : Colors.white,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image.network(
                            thumbnailUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<SelectedProductProvider>(
                builder: (context, selectedProductProvider, child) {
                  ComboProductListModel? selectedProduct =
                      selectedProductProvider.selectedProduct;
                  if (currentIndex < widget.thumbnailImageAndVideo!.length) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Combo Details ",
                              style:
                                  TextStyle(fontSize: 13, letterSpacing: 0.5),
                            ),
                            Text(
                              widget.comboName.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "₹${widget.comboPrice.toUpperCase()}/-",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      color: Colors.red),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "₹${int.parse(widget.comboPrice) + 1501}/-",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.5,
                                      color: Colors.black,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Description: ",
                              style:
                                  TextStyle(fontSize: 13, letterSpacing: 0.5),
                            ),
                            Text(
                              widget.comboDescription,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  } else if (selectedProduct == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  bool isVideoThumbnail = currentIndex <
                          widget.thumbnailImageAndVideo!.length &&
                      widget.thumbnailImageAndVideo![currentIndex]['type'] ==
                          'video';

                  String selectedSizeLabel = selectedSizes.containsKey(
                              currentIndex -
                                  widget.thumbnailImageAndVideo!.length) &&
                          selectedSizes[currentIndex -
                                  widget.thumbnailImageAndVideo!.length]!
                              .isNotEmpty
                      ? "Selected Size: ${selectedSizes[currentIndex - widget.thumbnailImageAndVideo!.length]}"
                      : "Select Size";

                  bool isAccessory =
                      selectedProduct.name.toLowerCase().contains("accessory");

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Product Details: ",
                            style: TextStyle(fontSize: 13, letterSpacing: 0.5),
                          ),
                          Text(
                            widget.comboName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Description: ",
                            style: TextStyle(fontSize: 13, letterSpacing: 0.5),
                          ),
                          Text(
                            selectedProduct.description,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (!isVideoThumbnail && !isAccessory)
                            const SizedBox(height: 10),
                          if (!isVideoThumbnail && !isAccessory)
                            TextButton(
                              onPressed: () {
                                _showSizePicker(
                                    context,
                                    currentIndex -
                                        widget.thumbnailImageAndVideo!.length);
                              },
                              child: Text(
                                selectedSizeLabel,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          if (!isVideoThumbnail)
                            addedToCombo
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Item added to Combo'.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      toggleCombo();
                                    },
                                    child: const Text(
                                      'Add to Combo',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: comboList.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Attention: 4 Products Mandatory! Your Combo Must Contain Exactly 4 Items. Adjust Accordingly. ⚠️",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Combo Items:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: comboList.length,
                      itemBuilder: (context, index) {
                        // bool minComboLength =
                        // comboList.length < 3 ? true : false;
                        final comboItem = comboList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(comboItem.image),
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ComboAddedItems(
                                          title: "Name",
                                          text: comboItem.productName),
                                      ComboAddedItems(
                                          title: "Size",
                                          text: comboItem.selectedSize),
                                    ],
                                  ),
                                  const Spacer(),
                                  ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Remove?"),
                                              content: const Text(
                                                  "This item will be removed from Selected Combo Products"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      comboList.removeAt(index);
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 17,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        if (comboList.length == comboLengthForBuying) {
                          try {
                            debugPrint(userId);

                            List<Map<String, dynamic>> comboData =
                                comboList.map((comboItem) {
                              return {
                                'productId': comboItem.productId,
                                'productName': comboItem.productName,
                                'selectedSize': comboItem.selectedSize,
                                'image': comboItem.image,
                                'description': comboItem.description,
                              };
                            }).toList();

                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(userId)
                                .collection("cartCollection_Combos")
                                .add({
                              'selectedItems': comboData,
                              "itemCountcustomer": 1,
                              "productDetailsCombo": productDetailsCombo
                            }).then((value) {
                              setState(() {
                                comboList.clear();
                                selectedSizes.clear();
                              });
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Success"),
                                    content: Text(
                                        "Combo has been successfully added to your cart."),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }).catchError((error) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                        "Failed to add combo to your cart. Please try again."),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            });

                            debugPrint("Added to Firestore");
                          } catch (e) {
                            debugPrint("Failed to add to Firestore: $e");
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Hey there!"),
                                content: Text(
                                    "You can buy only $comboLengthForBuying items in combo!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text("Add to Cart"),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      // onTap: () {
                      //   Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) => CartPage(), // Navigate to CartPage
                      //                 ),
                      //   );
                      // },
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CartPage(), // Navigate to CartPage
                            ),
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: Text('go to cart')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ComboProductListModel> fetchProducts(List<dynamic> itemsInCombo) {
    List<ComboProductListModel> products = [];
    for (var item in itemsInCombo) {
      if (item is Map<String, dynamic>) {
        products.add(ComboProductListModel.fromMap(item));
      }
    }
    return products;
  }

  // void _showSizePicker(BuildContext context, int productIndex) {
  //   List<String> sizeList = pantSizesList;
  //   if (products[productIndex].name.toLowerCase().contains("shoe")) {
  //     sizeList = shoeSizesList;
  //   } else if (!products[productIndex].name.toLowerCase().contains("jeans") &&
  //       !products[productIndex].name.toLowerCase().contains("jean") &&
  //       !products[productIndex].name.toLowerCase().contains("pants") &&
  //       !products[productIndex].name.toLowerCase().contains("pant")) {
  //     sizeList = shirtSizesList;
  //   }

  //   String initialSize = selectedSizes[productIndex] ?? sizeList[0];

  //   void showCupertinoModalPopup(BuildContext context) {
  //     showModalBottomSheet<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: 216,
  //           padding: const EdgeInsets.only(top: 6.0),
  //           margin: EdgeInsets.only(
  //             bottom: MediaQuery.of(context).viewInsets.bottom,
  //           ),
  //           color: Colors.white, // Use Colors.white or any Material color
  //           child: SafeArea(
  //             top: false,
  //             child: ListWheelScrollView.useDelegate(
  //               controller: FixedExtentScrollController(
  //                 initialItem: sizeList.indexOf(initialSize),
  //               ),
  //               itemExtent: 32.0,
  //               onSelectedItemChanged: (int selectedItem) {
  //                 setState(() {
  //                   selectedSizes[productIndex] = sizeList[selectedItem];
  //                 });
  //               },
  //               childDelegate: ListWheelChildBuilderDelegate(
  //                 builder: (context, index) {
  //                   if (index >= 0 && index < sizeList.length) {
  //                     return Center(
  //                       child: Text(sizeList[index]),
  //                     );
  //                   }
  //                   return null;
  //                 },
  //                 childCount: sizeList.length,
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }
  void _showSizePicker(BuildContext context, int productIndex) {
    List<String> sizeList = pantSizesList;
    if (products[productIndex].name.toLowerCase().contains("shoe")) {
      sizeList = shoeSizesList;
    } else if (!products[productIndex].name.toLowerCase().contains("jeans") &&
        !products[productIndex].name.toLowerCase().contains("jean") &&
        !products[productIndex].name.toLowerCase().contains("pants") &&
        !products[productIndex].name.toLowerCase().contains("pant")) {
      sizeList = shirtSizesList;
    }

    String initialSize = selectedSizes[productIndex] ?? sizeList[0];

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Size'),
          content: DropdownButton<String>(
            value: initialSize,
            onChanged: (String? newSize) {
              if (newSize != null) {
                setState(() {
                  selectedSizes[productIndex] = newSize;
                });
                Navigator.of(context).pop();
              }
            },
            items: sizeList.map<DropdownMenuItem<String>>((String size) {
              return DropdownMenuItem<String>(
                value: size,
                child: Text(size),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void toggleCombo() {
    int productIndex = currentIndex - widget.thumbnailImageAndVideo!.length;

    if (productIndex >= 0) {
      ComboProductListModel selectedProduct = products[productIndex];
      bool isAccessory =
          selectedProduct.name.toLowerCase().contains("accessory");

      if (!isAccessory &&
          (!selectedSizes.containsKey(productIndex) ||
              selectedSizes[productIndex]!.isEmpty)) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Size Required"),
              content:
                  const Text("Please select a size before adding to combo."),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        return;
      }

      setState(() {
        if (addedToCombo) {
          comboList
              .removeWhere((combo) => combo.productId == selectedProduct.id);
        } else {
          bool productIdExists =
              comboList.any((combo) => combo.productId == selectedProduct.id);
          if (!productIdExists) {
            comboList.add(ComboModel(
              productId: selectedProduct.id,
              productName: selectedProduct.name,
              selectedSize: isAccessory
                  ? "Not applicable"
                  : selectedSizes[productIndex] ?? "Not selected",
              image: selectedProduct.imageUrl,
              description: selectedProduct.description,
            ));
          }
        }

        addedToCombo = !addedToCombo;
      });
    }
  }

  void _updateButtonLabel(int index) {
    setState(() {
      if (index >= widget.thumbnailImageAndVideo!.length) {
        int productIndex = index - widget.thumbnailImageAndVideo!.length;
        currentIndex = index;
        Provider.of<SelectedProductProvider>(context, listen: false)
            .setSelectedProduct(products[productIndex]);
        addedToCombo = comboList.any(
          (combo) => combo.productId == products[productIndex].id,
        );
      } else {
        currentIndex = index;
        Provider.of<SelectedProductProvider>(context, listen: false)
            .setSelectedProduct(null);
        addedToCombo = false;
      }
    });

    _carouselController.animateToPage(
      index,
      // duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
