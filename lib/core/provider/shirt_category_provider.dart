import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuni/data/constraints.dart';
import '../model/product_model.dart';
 
class ShirtCategoryProvider extends ChangeNotifier {
  List<Product> _allShirts = [];
 
  List<Product> get allShirts => _allShirts;
 
  Future<List<Product>> fetchShirts() async {
    QuerySnapshot plainFullSleeveTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(shirtCollectionName)
        .doc("collar")
        .collection("Printed")
        .get();
 
 
 
    return plainFullSleeveTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  Future<void> fetchAndCombineShirts() async {
    final shirtsList = await fetchShirts();
    // final printedFullSleeve = await fetchPrintedFullSleeveTShirts();
 
    _allShirts = [...shirtsList];
    notifyListeners();
  }
}