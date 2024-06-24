import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:tuni/core/model/Order_history_model.dart';

class OrderHistoryProvider extends ChangeNotifier {
  List<OrderHistoryModel> _orderHistoryItems = [];

  List<OrderHistoryModel> get orderHistoryItems => _orderHistoryItems;

  Future<void> fetchOrderHistoryItems({required String userId}) async {
    _orderHistoryItems.clear();

    final _firestore = FirebaseFirestore.instance;
    debugPrint("reached here");

    try {
      QuerySnapshot orderHistorySnapshot = await _firestore
          .collection("AllOrderList")
          .doc(userId)
          .collection("OrderAddress_History")
          .get();

      if (orderHistorySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot orderDoc in orderHistorySnapshot.docs) {
          Map<String, dynamic> data = orderDoc.data() as Map<String, dynamic>;
          OrderHistoryModel orderData = OrderHistoryModel.fromMap(data);
          _orderHistoryItems.add(orderData);
        }
      }
    } catch (e) {
      throw e.toString();
    }

    try {
      QuerySnapshot comboHistorySnapshot = await _firestore
          .collection("AllOrderList")
          .doc(userId)
          .collection("OrderAddress_History_Combos")
          .get();

      if (comboHistorySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot comboDoc in comboHistorySnapshot.docs) {
          Map<String, dynamic> data = comboDoc.data() as Map<String, dynamic>;
          OrderHistoryModel comboData = OrderHistoryModel.fromMap(data);
          _orderHistoryItems.add(comboData);
        }
      }
    } catch (e) {
      throw e.toString();
    }

    debugPrint(
        "order History Items in Provider page: ${_orderHistoryItems.toString()}");

    notifyListeners();
  }
}
