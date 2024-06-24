import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/cart_model.dart';

class CartProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CartItemModel> items = [];

  List<CartItemModel> get cartItemList => items;

  int calculateTotalPrice() {
    int totalPrice = 0;

    for (var item in items) {
      if (item.comboProductDetails != null &&
          item.comboProductDetails!.isNotEmpty) {
        int comboItemCount = item.comboItemCountCustomer ?? 0;
        int comboPrice = int.tryParse(
                item.comboProductDetails?['price']?.toString() ?? '0') ??
            0;
        totalPrice += comboPrice * comboItemCount;
      } else {
        int itemPrice = int.tryParse(item.productPrice ?? '0') ?? 0;
        totalPrice += itemPrice * (item.productItemCountCustomer ?? 0);
      }
    }

    return totalPrice;
  }

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

      // for (var doc in productSnapshot.docs) {
      //   String docId = doc.id;
      //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // }

      if (productSnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot cartDoc in productSnapshot.docs) {
          Map<String, dynamic> data = cartDoc.data() as Map<String, dynamic>;
          CartItemModel cartData = CartItemModel.fromCartMap(data);
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
      for (var doc in comboSnapshot.docs) {
        String docId = doc.id;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        CartItemModel comboData = CartItemModel.fromComboMap(docId, data);
        items.add(comboData);
      }
    } catch (e) {
      throw e.toString();
    }

    notifyListeners();
  }

  Future<void> deleteCartItem({
    required String productId,
    required int index,
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

  Future<void> deleteCartComboItem(
      {required String productId,
      required int index,
      required String comboDocId}) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      cartItemList.removeAt(index);
      debugPrint("deleting function combo ID: $comboDocId");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("cartCollection_Combos")
          .doc(comboDocId)
          .delete();
      notifyListeners();
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> checkOut({
    required List<CartItemModel> orderList,
    required Map<String, dynamic> address,
    required int totalPrice,
    required List<String> ids,
  }) async {
    List<Map<String, dynamic>> orderedProductsList = [];
    List<Map<String, dynamic>> orderedComboList = [];
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final int generateNumber = DateTime.now().millisecondsSinceEpoch % 100000;
    final orderId = "#$generateNumber";
    Map<String, dynamic> comboProductDetails = {};
    List<dynamic> comboSelectedItems = [];

    for (var item in orderList) {
      if (item.productId != null && item.productId!.isNotEmpty) {
        orderedProductsList.add(item.toMap());
      } else {}

      if (item.comboDocId != null && item.comboDocId!.isNotEmpty) {
        orderedComboList.add(item.toMap());
      } else {}
    }

    bool hasSelectedItems = orderedComboList.any((combo) =>
        combo['comboSelectedItems'] != null &&
        (combo['comboSelectedItems'] as List).isNotEmpty);

    debugPrint("has selected Items: ${hasSelectedItems.toString()}");

    for (var combo in orderedComboList) {
      if (combo['comboProductDetails'] != null) {
        comboProductDetails =
            combo['comboProductDetails'] as Map<String, dynamic>;
        debugPrint("comboProductDetails: $comboProductDetails");
        comboSelectedItems = combo['comboSelectedItems'];
        debugPrint("comboProductDetails: $comboSelectedItems");
      }
    }

    // Adding combo
    if (hasSelectedItems) {
      await FirebaseFirestore.instance
          .collection("AllOrderList")
          .doc(userId)
          .collection("OrderItemPlaced_Combo")
          .add({
        "orderID": orderId,
        "itemCountcustomer": 1,
        "orderAddress": address,
        "selectedItems": comboSelectedItems,
        "productDetailsCombo": comboProductDetails,
        "totalPrice": totalPrice,
        "orderStatus": false
      });
      await FirebaseFirestore.instance
          .collection("AllOrderList")
          .doc(userId)
          .collection("OrderAddress_History_Combos")
          .add({
        "orderID": orderId,
        "itemCountcustomer": 1,
        "orderAddress": address,
        "selectedItems": comboSelectedItems,
        "productDetailsCombo": comboProductDetails,
        "totalPrice": totalPrice,
        "orderStatus": false
      });
    }

    // Adding products
    for (var product in orderedProductsList) {
      await FirebaseFirestore.instance
          .collection("AllOrderList")
          .doc(userId)
          .collection("OrderItemPlaced")
          .add({
        "orderID": orderId,
        "orderStatus": false,
        "orderAddress": address,
        "totalPrice": totalPrice,
        ...product
      });

      await FirebaseFirestore.instance
          .collection("AllOrderList")
          .doc(userId)
          .collection("OrderAddress_History")
          .add({
        "orderID": orderId,
        "orderStatus": false,
        "orderAddress": address,
        "totalPrice": totalPrice,
        ...product
      });
    }

    await _deleteCollection(userId, "cartCollection");
    await _deleteCollection(userId, "cartCollection_Combos");
  }

  Future<void> _deleteCollection(String userId, String collectionName) async {
    final collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection(collectionName);

    const int batchSize = 100;

    Future<bool> deleteBatch(Query query) async {
      final snapshot = await query.get();
      final batch = FirebaseFirestore.instance.batch();
      for (DocumentSnapshot doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      return snapshot.size == batchSize;
    }

    bool batchDeleted;
    do {
      batchDeleted = await deleteBatch(collectionRef.limit(batchSize));
    } while (batchDeleted);
  }
}
