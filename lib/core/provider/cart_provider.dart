import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/cart_model.dart';

class CartProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CartItemModel> items = [];

  List<CartItemModel> get cartItemList => items;

  Future<void> increaseCartQuantity(
    String userId,
    String productId,
    int currentQuantity,
  ) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cartCollection')
        .doc(productId)
        .update({'itemCountcustomer': currentQuantity + 1});
    await fetchCartItems(userId: userId);
  }

  Future<void> decreaseCartQuantity(
    String userId,
    String productId,
    int currentQuantity,
  ) async {
    if (currentQuantity > 1) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cartCollection')
          .doc(productId)
          .update({'itemCountcustomer': currentQuantity - 1});
      await fetchCartItems(userId: userId);
    }
  }

  Future<void> fetchCartItems({required String userId}) async {
    items.clear();
    try {
      QuerySnapshot productSnapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("cartCollection")
          .get();

      if (productSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot cartDoc in productSnapshot.docs) {
          Map<String, dynamic> data = cartDoc.data() as Map<String, dynamic>;
          CartItemModel cartData = CartItemModel.fromMap(data);
          items.add(cartData);
        }
      }
    } catch (e) {
      throw e.toString();
    }

    try {
      QuerySnapshot comboSnapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("cartCollection_Combos")
          .get();
      if (comboSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot comboDoc in comboSnapshot.docs) {
          Map<String, dynamic> data = comboDoc.data() as Map<String, dynamic>;
          CartItemModel comboData = CartItemModel.fromMap(data);
          items.add(comboData);
        }
      }
    } catch (e) {
      throw e.toString();
    }

    notifyListeners();
  }

  Future<void> deleteCartItem({
    required String productId,
    required int index,
    // required List<CartItemModel> cartItemList
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    cartItemList.removeAt(index);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cartCollection')
        .doc(productId)
        .delete();
    notifyListeners();
  }

  Future<void> deleteCartComboItem({
    // required String productDetailsCombo,
    required int index,
    // required List<CartItemModel> cartItemList,
    required String productId,
  }) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot comboSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cartCollection_Combos')
        .where(productId, isEqualTo: userId)
        .get();

    // debugPrint("id: ${comboSnapshot.docs["id"]}");

    // if (comboSnapshot.docs.isNotEmpty) {
    //   DocumentSnapshot document = comboSnapshot.docs.first;

    cartItemList.removeAt(index);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cartCollection_Combos')
        .doc(productId)
        .delete();

    notifyListeners();
    // } else {
    //   print('No document found with the specified productDetailsCombo ID.');
    // }
  }
}
