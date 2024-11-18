import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/provider/cart_provider.dart';
import 'cart_refactor.dart';
import 'checkout/select_address.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool _isLoadingTimedOut = false;
  bool isComboAdded = false;
  List<String> ids = [];

  @override
  void initState() {
    super.initState();
    if (user != null) {
      Future.microtask(() {
        Provider.of<CartProvider>(context, listen: false)
            .fetchCartItems(userId: user!.uid)
            .then((_) {
          final cartProvider =
              Provider.of<CartProvider>(context, listen: false);
          bool comboInCart = cartProvider.cartItemList.any(
              (item) => item.comboDocId != null && item.comboDocId!.isNotEmpty);
          setState(() {
            isComboAdded = comboInCart;
          });
        });
      });
    }

    Future.delayed(const Duration(seconds: 2), () {
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("CART"),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (user == null) {
            return const Center(child: Text('You are not logged in'));
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            bool comboInCart = cartProvider.cartItemList.any((item) =>
                item.comboDocId != null && item.comboDocId!.isNotEmpty);
            if (comboInCart != isComboAdded) {
              setState(() {
                isComboAdded = comboInCart;
              });
            }
          });

          if (cartProvider.cartItemList.isEmpty) {
            if (_isLoadingTimedOut) {
              return const Center(
                child: Text('Your Cart is Empty'),
              );
            } else {
              return Center(
                child: user!.isAnonymous
                    ? const Text('You are using Guest Account')
                    : const CircularProgressIndicator(),
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
                    final String? id = value.productId;
                    final String? color = value.productColor;
                    final List<String>? imageUrl = value.productImageUrl;
                    final int? itemCountCustomer =
                        value.productItemCountCustomer;
                    final String? name = value.productName;
                    final String? price = value.productPrice;
                    final String? sizecustomers = value.productSizeCustomers;
                    final int? comboItemCountCustomer =
                        value.comboItemCountCustomer;
                    final Map<String, dynamic>? comboProductDetails =
                        value.comboProductDetails;
                    // final List<dynamic>? comboSelectedItems =
                    //     value.comboSelectedItems;
                    final String? comboDocId = value.comboDocId;

                    if (id != null && id.isNotEmpty) {
                      if (!ids.contains(id + sizecustomers!)) {
                        ids.add(id + sizecustomers);
                      }
                      return ProductCartItemWidget(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        productImageUrl: imageUrl,
                        productName: name,
                        productSizeCustomers: sizecustomers,
                        productColor: color,
                        productPrice: price!,
                        userId: userId,
                        cartProductId: id + sizecustomers,
                        productItemCountCustomer: itemCountCustomer ?? 0,
                        index: index,
                        cartList: cartProvider.cartItemList,
                      );
                    } else if (comboDocId != null && comboDocId.isNotEmpty) {
                      final comboId = comboProductDetails?["id"];
                      final comboName = comboProductDetails?["name"];
                      final comboPrice = comboProductDetails?["price"];
                      final comboThumbnailImage =
                          comboProductDetails?["tumbnail"] ?? "";
                      if (comboDocId.isNotEmpty && !ids.contains(comboDocId)) {
                        ids.add(comboDocId);
                      }

                      return ComboCartItemWidget(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        userId: userId,
                        index: index,
                        comboThumbnailImage: comboThumbnailImage,
                        comboName: comboName,
                        cartComboId: comboId,
                        comboPrice: comboPrice,
                        comboItemCountCustomer: comboItemCountCustomer ?? 0,
                        comboDocId: comboDocId,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //   child: Container(
              //     height: 200,
              //     width: screenWidth,
              //     decoration: BoxDecoration(
              //       color: CupertinoColors.systemGrey,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Column(
              //       children: [],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10),
              Consumer<CartProvider>(
                builder: (context, value, child) {
                  int totalPrice = value.calculateTotalPrice();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: Visibility(
                        visible: cartProvider.cartItemList.isNotEmpty,
                        child: ElevatedButton(
                          child: Text(
                            "CONTINUE - ₹${totalPrice.toString()} /-",
                            style: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('CART'),
                                  content: Text(
                                    "Your cart total is ₹${totalPrice.toString()} Proceed to checkout?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        debugPrint(isComboAdded.toString());
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SelectAddress(
                                              orderList: value.cartItemList,
                                              total: totalPrice,
                                              ids: ids,
                                              isComboAdded: isComboAdded,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text("CHECKOUT"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20)
            ],
          );
        },
      ),
    );
  }
}
