// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:tuni/core/model/Cart_models.dart';
// import '../../../core/model/cart_model.dart';
// import '../../../core/provider/cart_provider.dart';

// Widget cartCheckoutSubHeadings({
//   required String headingName,
// }) {
//   return Text(
//     headingName,
//     style: const TextStyle(
//         letterSpacing: 1.5, fontSize: 16, fontWeight: FontWeight.w500),
//   );
// }

// // Widget personalDetailsTextFormField(
// //     {required TextEditingController controller, required String hintText}) {
// //   return SizedBox(
// //     height: 50,
// //     child: Platform.isAndroid
// //         ? TextFormField(
// //             controller: controller,
// //             decoration: InputDecoration(
// //                 border: OutlineInputBorder(
// //                     borderSide: BorderSide.none,
// //                     borderRadius: BorderRadius.circular(10)),
// //                 hintText: hintText,
// //                 filled: true,
// //                 fillColor: Colors.grey.shade100,
// //                 labelText: hintText),
// //           )
// //         : CupertinoTextField(
// //             controller: controller,
// //             placeholder: hintText,
// //           ),
// //   );
// // }

// Widget richTextInCheckout({required String content, required String text}) {
//   return RichText(
//     text: TextSpan(
//         text: '$content: ',
//         children: [
//           TextSpan(
//               text: text.toUpperCase(),
//               style: const TextStyle(color: Colors.black))
//         ],
//         style: const TextStyle(color: Colors.black, letterSpacing: 0.5)),
//   );
// }

// class ProductCartItemWidget extends StatelessWidget {
//   const ProductCartItemWidget({
//     super.key,
//     required this.screenHeight,
//     required this.screenWidth,
//     required this.productImageUrl,
//     required this.productName,
//     required this.productSizeCustomers,
//     required this.productColor,
//     required this.productPrice,
//     required this.userId,
//     required this.cartProductId,
//     required this.productItemCountCustomer,
//     required this.index,
//     required this.cartList,
//   });

//   final double screenHeight;
//   final double screenWidth;
//   final List<String>? productImageUrl;
//   final String? productName;
//   final String? productSizeCustomers;
//   final String? productColor;
//   final String productPrice;
//   final String? userId;
//   final String cartProductId;
//   final int? productItemCountCustomer;
//   final int index;
//   final List<CartItemModel> cartList;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       child: Container(
//         height: screenHeight * .15,
//         width: screenWidth,
//         decoration: const BoxDecoration(
//           color: CupertinoColors.white,
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(
//                   productImageUrl![0],
//                   fit: BoxFit.cover,
//                   width: screenWidth * .25,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: screenWidth * .6,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Flexible(
//                           child: Text(
//                             productName!,
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ),
//                         Consumer<CartProvider>(
//                           builder: (context, value, child) {
//                             return CupertinoButton(
//                               padding: EdgeInsets.zero,
//                               child: const Text(
//                                 "Remove",
//                                 style:
//                                     TextStyle(color: CupertinoColors.systemRed),
//                               ),
//                               onPressed: () {
//                                 showCupertinoDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return CupertinoAlertDialog(
//                                       title: const Text("Are you sure?"),
//                                       content: const Text(
//                                           "Do you want to remove this item from cart?"),
//                                       actions: [
//                                         CupertinoDialogAction(
//                                           onPressed: () {
//                                             Navigator.pop(context, false);
//                                           },
//                                           child: const Text(
//                                             "No",
//                                             style: TextStyle(
//                                                 color:
//                                                     CupertinoColors.systemRed),
//                                           ),
//                                         ),
//                                         CupertinoDialogAction(
//                                           onPressed: () {
//                                             Navigator.pop(context, true);
//                                             value.deleteCartItem(
//                                               productId: cartProductId,
//                                               index: index,
//                                               // cartItemList: cartList
//                                             );
//                                           },
//                                           child: const Text("Yes"),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: screenWidth * .6,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '₹$productPrice/-',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 1,
//                           ),
//                         ),
//                         Consumer<CartProvider>(
//                           builder: (context, cartProvider, child) {
//                             return Container(
//                               width: 115,
//                               height: 35,
//                               decoration: BoxDecoration(
//                                 border:
//                                     Border.all(color: CupertinoColors.black),
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(7)),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   CupertinoButton(
//                                     padding: EdgeInsets.zero,
//                                     child: const Icon(CupertinoIcons.minus,
//                                         size: 15),
//                                     onPressed: () {
//                                       cartProvider.decreaseCartQuantity(
//                                         userId!,
//                                         cartProductId,
//                                         productItemCountCustomer!,
//                                       );
//                                     },
//                                   ),
//                                   Text(
//                                     productItemCountCustomer.toString(),
//                                     style: const TextStyle(fontSize: 15),
//                                   ),
//                                   CupertinoButton(
//                                     padding: EdgeInsets.zero,
//                                     child: const Icon(CupertinoIcons.add,
//                                         size: 15),
//                                     onPressed: () {
//                                       cartProvider.increaseCartQuantity(
//                                         userId!,
//                                         cartProductId,
//                                         productItemCountCustomer!,
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ComboCartItemWidget extends StatelessWidget {
//   const ComboCartItemWidget({
//     super.key,
//     required this.screenHeight,
//     required this.screenWidth,
//     required this.comboThumbnailImage,
//     required this.comboName,
//     required this.cartComboId,
//     required this.comboPrice,
//     required this.userId,
//     required this.comboItemCountCustomer,
//     required this.index,
//   });

//   final double screenHeight;
//   final double screenWidth;
//   final String comboThumbnailImage;
//   final String? comboName;
//   final String cartComboId;
//   final String? comboPrice;
//   final String? userId;
//   final int comboItemCountCustomer;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//       child: Container(
//         height: screenHeight * .15,
//         width: screenWidth,
//         decoration: const BoxDecoration(
//           boxShadow: [
//             // BoxShadow(
//             //   color: CupertinoColors.white,
//             //   spreadRadius: 1,
//             //   blurRadius: 7,
//             //   offset: Offset(0, 2),
//             // ),
//           ],
//           color: CupertinoColors.white,
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.network(
//                   comboThumbnailImage,
//                   fit: BoxFit.cover,
//                   // height: screenHeight * .15,
//                   width: screenWidth * .25,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: screenWidth * .6,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Flexible(
//                           child: Text(
//                             comboName!,
//                             // overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ),
//                         Consumer<CartProvider>(
//                           builder: (context, value, child) {
//                             return CupertinoButton(
//                               padding: EdgeInsets.zero,
//                               child: const Text(
//                                 "Remove",
//                                 style:
//                                     TextStyle(color: CupertinoColors.systemRed),
//                               ),
//                               onPressed: () {
//                                 showCupertinoDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return CupertinoAlertDialog(
//                                       title: const Text("Are you sure?"),
//                                       content: const Text(
//                                           "Do you want to remove this item from cart?"),
//                                       actions: [
//                                         CupertinoDialogAction(
//                                           onPressed: () {
//                                             Navigator.pop(context, false);
//                                           },
//                                           child: const Text(
//                                             "No",
//                                             style: TextStyle(
//                                                 color:
//                                                     CupertinoColors.systemRed),
//                                           ),
//                                         ),
//                                         CupertinoDialogAction(
//                                           onPressed: () {
//                                             Navigator.pop(context, true);
//                                             value.deleteCartComboItem(
//                                               productId: cartComboId,
//                                               index: index,
//                                               // cartItemList:
//                                             );
//                                           },
//                                           child: const Text("Yes"),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: screenWidth * .6,
//                     child:
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //   children: [
//                         Text(
//                       '₹$comboPrice/-',
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                     // Consumer<CartProvider>(
//                     //   builder: (context, cartProvider, child) {
//                     //     return Container(
//                     //       width: 115,
//                     //       height: 35,
//                     //       decoration: BoxDecoration(
//                     //         border:
//                     //             Border.all(color: CupertinoColors.black),
//                     //         borderRadius:
//                     //             const BorderRadius.all(Radius.circular(7)),
//                     //       ),
//                     //       child: Row(
//                     //         mainAxisAlignment:
//                     //             MainAxisAlignment.spaceEvenly,
//                     //         children: [
//                     //           CupertinoButton(
//                     //             padding: EdgeInsets.zero,
//                     //             child: const Icon(CupertinoIcons.minus,
//                     //                 size: 15),
//                     //             onPressed: () {
//                     //               cartProvider.decreaseCartQuantity(
//                     //                 userId!,
//                     //                 cartComboId,
//                     //                 comboItemCountCustomer,
//                     //               );
//                     //             },
//                     //           ),
//                     //           Text(
//                     //             comboItemCountCustomer.toString(),
//                     //             style: const TextStyle(fontSize: 15),
//                     //           ),
//                     //           CupertinoButton(
//                     //             padding: EdgeInsets.zero,
//                     //             child: const Icon(CupertinoIcons.add,
//                     //                 size: 15),
//                     //             onPressed: () {
//                     //               cartProvider.increaseCartQuantity(
//                     //                 userId!,
//                     //                 cartComboId,
//                     //                 comboItemCountCustomer!,
//                     //               );
//                     //             },
//                     //           ),
//                     //         ],
//                     //       ),
//                     //     );
//                     //   },
//                     // )
//                     //   ],
//                     // ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget personalDetailsTextFormField({
//   required TextEditingController controller,
//   required String hintText,
// }) {
//   List<TextInputFormatter>? inputFormatters = [
//     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
//   ];

//   return SizedBox(
//     height: 50,
//     child: TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.grey.shade100,
//         labelText: hintText,
//       ),
//       keyboardType: TextInputType.text,
//       inputFormatters: inputFormatters,
//     ),
//   );
// }

// // Widget for capturing the mobile number
// Widget personalDetailsTextFormField1({
//   required TextEditingController controller,
//   required String hintText,
// }) {
//   List<TextInputFormatter>? inputFormatters = [
//     FilteringTextInputFormatter.digitsOnly,
//     LengthLimitingTextInputFormatter(10) // Limit input to 10 characters
//   ];

//   return SizedBox(
//     height: 50,
//     child: TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         hintText: 'Mobile Number',
//         filled: true,
//         fillColor: Colors.grey.shade100,
//         labelText: 'Mobile Number',
//       ),
//       keyboardType: TextInputType.phone,
//       inputFormatters: inputFormatters,
//     ),
//   );
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/model/cart_model.dart';
import '../../../core/provider/cart_provider.dart';

Widget cartCheckoutSubHeadings({
  required String headingName,
}) {
  return Text(
    headingName,
    style: const TextStyle(
        letterSpacing: 1.5, fontSize: 16, fontWeight: FontWeight.w500),
  );
}

Widget richTextInCheckout({required String content, required String text}) {
  return RichText(
    text: TextSpan(
        children: [
          TextSpan(
              text: '$content: ',
              style: const TextStyle(color: Colors.grey, fontSize: 13)),
          TextSpan(
              text: text.toUpperCase(),
              style: const TextStyle(color: Colors.black)),
        ],
        style: const TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500)),
  );
}

class ProductCartItemWidget extends StatelessWidget {
  const ProductCartItemWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.productImageUrl,
    required this.productName,
    required this.productSizeCustomers,
    required this.productColor,
    required this.productPrice,
    required this.userId,
    required this.cartProductId,
    required this.productItemCountCustomer,
    required this.index,
    required this.cartList,
  });

  final double screenHeight;
  final double screenWidth;
  final List<String>? productImageUrl;
  final String? productName;
  final String? productSizeCustomers;
  final String? productColor;
  final String productPrice;
  final String? userId;
  final String cartProductId;
  final int? productItemCountCustomer;
  final int index;
  final List<CartItemModel> cartList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        height: screenHeight * .15,
        width: screenWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  productImageUrl![0],
                  fit: BoxFit.cover,
                  width: screenWidth * .25,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * .6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            productName!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Consumer<CartProvider>(
                          builder: (context, value, child) {
                            return TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                iconColor: Colors.red,
                              ),
                              child: const Text(
                                "Remove",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Are you sure?"),
                                      content: const Text(
                                          "Do you want to remove this item from cart?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text(
                                            "No",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                            value.deleteCartItem(
                                              productId: cartProductId,
                                              index: index,
                                            );
                                          },
                                          child: const Text("Yes"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹$productPrice/-',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            return Container(
                              width: 115,
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.remove, size: 15),
                                    onPressed: () {
                                      cartProvider.decreaseCartQuantity(
                                        userId!,
                                        cartProductId,
                                        productItemCountCustomer!,
                                      );
                                    },
                                  ),
                                  Text(
                                    productItemCountCustomer.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.add, size: 15),
                                    onPressed: () {
                                      cartProvider.increaseCartQuantity(
                                        userId!,
                                        cartProductId,
                                        productItemCountCustomer!,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComboCartItemWidget extends StatelessWidget {
  const ComboCartItemWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.comboThumbnailImage,
    required this.comboName,
    required this.cartComboId,
    required this.comboPrice,
    required this.userId,
    required this.comboItemCountCustomer,
    required this.index,
    required this.comboDocId,
  });

  final double screenHeight;
  final double screenWidth;
  final String comboThumbnailImage;
  final String? comboName;
  final String cartComboId;
  final String? comboPrice;
  final String? userId;
  final int comboItemCountCustomer;
  final int index;
  final String comboDocId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        height: screenHeight * .15,
        width: screenWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  comboThumbnailImage,
                  fit: BoxFit.cover,
                  width: screenWidth * .25,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * .6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            comboName!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Consumer<CartProvider>(
                          builder: (context, value, child) {
                            return TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                iconColor: Colors.red,
                              ),
                              child: const Text(
                                "Remove",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Are you sure?"),
                                      content: const Text(
                                          "Do you want to remove this item from cart?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text(
                                            "No",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                            value.deleteCartComboItem(
                                              productId: cartComboId,
                                              index: index,
                                              comboDocId: comboDocId,
                                            );
                                          },
                                          child: const Text("Yes"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: screenWidth * .6,
                    child: Text(
                      '₹$comboPrice/-',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
