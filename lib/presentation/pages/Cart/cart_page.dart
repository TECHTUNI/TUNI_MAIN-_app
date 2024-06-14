// // ignore_for_file: must_be_immutable

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tuni/core/model/product_order_model.dart';
// import 'package:tuni/presentation/bloc/cart_bloc/cart_bloc.dart';
// import 'package:tuni/presentation/pages/Cart/checkout/select_address.dart';

// class CartPage extends StatefulWidget {
//   CartPage({super.key});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   int itemCount = 0;

//   int total = 0;

//   final User? user = FirebaseAuth.instance.currentUser;

//   @override
//   void dispose() {
//     // productIds.clear();
//     super.dispose();
//   }

//   List<OrderModel> productIds = [];

//   @override
//   Widget build(BuildContext context) {
//     String userId = user!.uid;
//     final firestore = FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .collection('cartCollection')
//         .snapshots();

//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'CART',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//             letterSpacing: 2,
//           ),
//         ),
//         centerTitle: true,
//         foregroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//               stream: firestore,
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 // productIds.clear();
//                 total = 0;

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return const Center(child: Text("Some error occurred"));
//                 }
//                 if (snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: SizedBox(
//                       height: screenHeight * .52,
//                       child: const Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [Text('Your Cart is Empty')],
//                       ),
//                     ),
//                   );
//                 }
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     final value = snapshot.data!.docs[index];
//                     final String id = value['id'].toString();
//                     final String image = value['imageUrl'][0].toString();
//                     final String name = value['name'].toString();
//                     final String size = value['sizecustomers'].toString();
//                     final String color = value['color'].toString();
//                     final int price = int.parse(value['price']);
//                     final int quantity = value['itemCountcustomer'];

//                     final int totalPrice = price * quantity;
//                     total += totalPrice;
//                     if (productIds.any((element) => element.productId == id)) {
//                       final existingItemIndex = productIds
//                           .indexWhere((element) => element.productId == id);

//                       productIds[existingItemIndex].quantity = quantity;
//                     } else {
//                       productIds
//                           .add(OrderModel(productId: id, quantity: quantity));
//                     }

//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 8),
//                       child: Container(
//                         height: screenHeight * .169,
//                         width: screenWidth,
//                         decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.1),
//                                 spreadRadius: 1,
//                                 blurRadius: 7,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                             color: Colors.grey.shade100,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(15))),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Row(children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.network(
//                                 image,
//                                 fit: BoxFit.cover,
//                                 height: screenHeight * .15,
//                                 width: screenWidth * .25,
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: screenWidth * .6,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Flexible(
//                                         child: Text(
//                                           name,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                               fontSize: 17,
//                                               fontWeight: FontWeight.bold,
//                                               letterSpacing: 1),
//                                         ),
//                                       ),
//                                       TextButton(
//                                           onPressed: () {
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return AlertDialog(
//                                                   content: const Text(
//                                                       "Remove this item from cart?"),
//                                                   actions: [
//                                                     TextButton(
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child:
//                                                             const Text("No")),
//                                                     TextButton(
//                                                         onPressed: () {
//                                                           context
//                                                               .read<CartBloc>()
//                                                               .add(OnDeleteCartItem(
//                                                                   id: id,
//                                                                   size: size));
//                                                           ScaffoldMessenger.of(
//                                                                   context)
//                                                               .showSnackBar(
//                                                                   const SnackBar(
//                                                             content: Text(
//                                                                 "Removed From Cart"),
//                                                             duration: Duration(
//                                                                 milliseconds:
//                                                                     1500),
//                                                           ));
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child:
//                                                             const Text("Yes"))
//                                                   ],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           child: const Text('Remove'))
//                                     ],
//                                   ),
//                                 ),
//                                 RichText(
//                                     text: TextSpan(
//                                         text: 'SIZE: ',
//                                         style: const TextStyle(
//                                             color: Colors.black),
//                                         children: [
//                                       TextSpan(
//                                           text: size,
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.w500))
//                                     ])),
//                                 RichText(
//                                     text: TextSpan(
//                                         text: 'COLOR: ',
//                                         style: const TextStyle(
//                                             color: Colors.black),
//                                         children: [
//                                       TextSpan(
//                                           text: color,
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.w500))
//                                     ])),
//                                 const Spacer(),
//                                 SizedBox(
//                                   width: screenWidth * .6,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         '₹$price/-',
//                                         style: const TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                             letterSpacing: 1),
//                                       ),
//                                       BlocBuilder<CartBloc, CartState>(
//                                         builder: (context, state) {
//                                           itemCount =
//                                               state is CartActionSuccessState
//                                                   ? quantity
//                                                   : quantity;
//                                           return Container(
//                                             width: 115,
//                                             height: 35,
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: Colors.black45),
//                                                 borderRadius:
//                                                     const BorderRadius.all(
//                                                         Radius.circular(7))),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 IconButton(
//                                                     onPressed: () {
//                                                       context
//                                                           .read<CartBloc>()
//                                                           .add(
//                                                               RemoveCartItemCountEvent(
//                                                             itemId: id,
//                                                             size: size,
//                                                           ));
//                                                     },
//                                                     icon: const Icon(
//                                                       Icons.remove,
//                                                       size: 15,
//                                                     )),
//                                                 Text(
//                                                   itemCount.toString(),
//                                                   style: const TextStyle(
//                                                       fontSize: 15),
//                                                 ),
//                                                 IconButton(
//                                                     onPressed: () {
//                                                       context.read<CartBloc>().add(
//                                                           AddCartItemCountEvent(
//                                                               itemId: id,
//                                                               size: size));
//                                                     },
//                                                     icon: const Icon(
//                                                       Icons.add,
//                                                       size: 15,
//                                                     )),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ]),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//         ],
//       )),
//       bottomNavigationBar: StreamBuilder<QuerySnapshot>(
//         stream: firestore,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             if (snapshot.data!.docs.isNotEmpty) {
//               return BottomAppBar(
//                 elevation: 0,
//                 color: Colors.white,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: SizedBox(
//                     height: 45,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: Text('Your Cart total is ₹$total/-'),
//                               content: const Text("Proceed to checkout?"),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text('cancel',
//                                       style: TextStyle(color: Colors.red)),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => SelectAddress(
//                                           orderList: productIds,
//                                           total: total,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: const Text('Go to checkout'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       child: const Text("PROCEED TO CHECKOUT"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueGrey,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/cart_provider.dart';
import 'cart_refactor.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool _isLoadingTimedOut = false;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      Future.microtask(() {
        Provider.of<CartProvider>(context, listen: false)
            .fetchCartItems(userId: user!.uid);
      });
    }

    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        _isLoadingTimedOut = true;
      });
    });
  }

  late int productItemCountCustomer;

  @override
  Widget build(BuildContext context) {
    String? userId = user?.uid;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey5,
      navigationBar: const CupertinoNavigationBar(
        middle: Text("CART"),
      ),
      child: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (user == null) {
            return const Center(child: Text('You are not logged in'));
          }

          if (cartProvider.cartItemList.isEmpty) {
            if (_isLoadingTimedOut) {
              return const Center(
                child:
                    Text('Failed to load cart items. Please try again later.'),
              );
            } else {
              return Center(
                child: user!.isAnonymous
                    ? const Text('You are using Guest Account')
                    : const CupertinoActivityIndicator(),
              );
            }
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartProvider.cartItemList.length,
                  itemBuilder: (context, index) {
                    final value = cartProvider.cartItemList[index];
                    final String? productId = value.productId;
                    // debugPrint("value${index + 1}: ${value.toString()}");
                    // debugPrint("name: ${value.productName}");
                    // debugPrint("productPrice: ${value.productPrice}");
                    // debugPrint("productColor: ${value.productColor}");
                    // debugPrint(
                    //     "productSizeCustomers: ${value.productSizeCustomers}");
                    // debugPrint("productImageUrl: ${value.productImageUrl}");
                    // debugPrint(
                    //     "productItemCountCustomer: ${value.productItemCountCustomer}");
                    // debugPrint("productId: ${value.productId}");
                    // debugPrint("combo${index + 1}");
                    //
                    // debugPrint(
                    //     "comboProductDetails: ${value.comboProductDetails}");
                    // debugPrint(
                    //     "comboItemCountCustomer: ${value.comboItemCountCustomer}");
                    // debugPrint(
                    //     "comboSelectedItems: ${value.comboSelectedItems}");

                    final String? productColor = value.productColor;
                    final List<String>? productImageUrl = value.productImageUrl;
                    productItemCountCustomer = value.productItemCountCustomer!;
                    final String? productName = value.productName;
                    final String? productPrice = value.productPrice;
                    final String productSizeCustomers =
                        value.productSizeCustomers ?? 'N/A';
                    final int? comboItemCountCustomer =
                        value.comboItemCountCustomer;
                    final Map<String, dynamic>? comboProductDetails =
                        value.comboProductDetails;
                    final List<dynamic>? comboSelectedItems =
                        value.comboSelectedItems;
                    final String cartProductId =
                        productId! + productSizeCustomers;

                    final comboId = comboProductDetails!["id"];
                    final comboName = comboProductDetails["name"];
                    final comboPrice = comboProductDetails["price"];
                    final comboThumbnailImage =
                        comboProductDetails["tumbnail"] ?? "";
                    // debugPrint(
                    //     "combo thumbnail image: ${comboThumbnailImage.toString()}");

                    final item = cartProvider.cartItemList[index];
                    if (item.productId != "null") {
                      return ProductCartItemWidget(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        productImageUrl: productImageUrl,
                        productName: productName,
                        productSizeCustomers: productSizeCustomers,
                        productColor: productColor,
                        productPrice: productPrice!,
                        userId: userId,
                        cartProductId: cartProductId,
                        productItemCountCustomer: productItemCountCustomer,
                        index: index,
                        cartList: cartProvider.cartItemList,
                      );
                    } else {
                      return ComboCartItemWidget(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        userId: userId,
                        index: index,
                        comboThumbnailImage: comboThumbnailImage,
                        comboName: comboName,
                        cartComboId: comboId,
                        comboPrice: comboPrice,
                        comboItemCountCustomer: comboItemCountCustomer!,
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: Visibility(
                    visible: cartProvider.cartItemList.isNotEmpty,
                    child: CupertinoButton.filled(
                      child: const Text("CHECKOUT",
                          style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text('CART'),
                              content: const Text("Proceed to checkout?"),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text(
                                    "No",
                                    style: TextStyle(
                                        color: CupertinoColors.systemRed),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text("CHECKOUT"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Implement the checkout logic here, like navigating to the checkout page
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
