import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuni/core/model/product_category_model.dart';

class ChatProvider extends ChangeNotifier {
  final List<ProductCategory> chatproducts = [];

  Future<List<ProductCategory>> fetchChatProducts(
      String gender, String category, String subcategory, String style) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("clothes")
        .doc(gender)
        .collection(category)
        .doc(subcategory)
        .collection(style)
        .get();

    for (var doc in snapshot.docs) {
      final Map<String, dynamic> data = doc.data();
      final ProductCategory product = ProductCategory(
        id: doc.id,
        name: data['name'] ?? '',
        brand: data['brand'] ?? '',
        gender: data['gender'] ?? '',
        price: data['price'] ?? '',
        time: data['time'] ?? '',
        imageUrlList: List<String>.from(data['imageUrl'] ?? []),
        quantity: data['Quantity'] ?? '',
        color: data['color'] ?? '',
        size: List<String>.from(data['size'] ?? []),
        type: data["type"] ?? "",
      );

      chatproducts.add(product);
    }
    return chatproducts;
  }
}
