import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tuni/data/constraints.dart';
 
import '../model/product_model.dart';
 
class TShirtCategoryProvider extends ChangeNotifier {
 
  //All Tshirts
  List<Product> _allTShirts = [];
 
  // Full Sleeve
  List<Product> _allFullSleeveTShirts = [];
 
  // Half Sleeve
  List<Product> _allHalfSleeveTShirts = [];
 
  // Collar
  List<Product> _allCollarTShirts = [];
 
  //Round Neck
  List<Product> _allRoundNeckTShirts = [];
 
  //V Neck
  List<Product> _allVNeckTShirts = [];
 
 
 
 
  // Getters
  List<Product> get allFullSleeveTShirts => _allFullSleeveTShirts;
  List<Product> get allHalfSleeveTShirts => _allHalfSleeveTShirts;
  List<Product> get allCollarTShirts => _allCollarTShirts;
  List<Product> get allRoundNeckTShirts => _allRoundNeckTShirts;
  List<Product> get allVNeckTShirts => _allVNeckTShirts;
  List<Product> get allTShirts => _allTShirts;
 
  // Plain full sleeve t-shirts
  Future<List<Product>> fetchPlainFullSleeveTShirts() async {
    QuerySnapshot plainFullSleeveTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(fullSleeveTShirt)
        .collection("Plain")
        .get();
 
    return plainFullSleeveTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Printed full sleeve t-shirts
  Future<List<Product>> fetchPrintedFullSleeveTShirts() async {
    QuerySnapshot printedFullSleeveTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(fullSleeveTShirt)
        .collection("check")
        .get();
 
    return printedFullSleeveTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Fetch and combine full sleeve t-shirts
  Future<void> fetchAndCombineFullSleeveTShirts() async {
    final plainFullSleeve = await fetchPlainFullSleeveTShirts();
    final printedFullSleeve = await fetchPrintedFullSleeveTShirts();
 
    _allFullSleeveTShirts = [...plainFullSleeve, ...printedFullSleeve];
    notifyListeners();
  }
 
  // HALF SLEEVE ==================================================================================
 
  // Plain half sleeve t-shirts
  Future<List<Product>> fetchPlainHalfSleeveTShirts() async {
    QuerySnapshot plainHalfSleeveTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(halfSleeveTShirt)
        .collection("Plain")
        .get();
 
    return plainHalfSleeveTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Printed half sleeve t-shirts
  Future<List<Product>> fetchPrintedHalfSleeveTShirts() async {
    QuerySnapshot printedHalfSleeveTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(halfSleeveTShirt)
        .collection("Printed")
        .get();
 
    return printedHalfSleeveTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Fetch and combine half sleeve t-shirts
  Future<void> fetchAndCombineHalfSleeveTShirts() async {
    final plainHalfSleeve = await fetchPlainHalfSleeveTShirts();
    final printedHalfSleeve = await fetchPrintedHalfSleeveTShirts();
 
    _allHalfSleeveTShirts = [...plainHalfSleeve, ...printedHalfSleeve];
    notifyListeners();
  }
 
  // COLLAR ================================================================================
// Plain Collar t-shirts
  Future<List<Product>> fetchPlainCollarTShirts() async {
    QuerySnapshot plainFullSleeveTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(collarTShirt)
        .collection("Plain")
        .get();
 
    return plainFullSleeveTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Printed Collar t-shirts
  Future<List<Product>> fetchPrintedCollarTShirts() async {
    QuerySnapshot printedFullSleeveTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(collarTShirt)
        .collection("Printed")
        .get();
 
    return printedFullSleeveTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Fetch and combine Collar t-shirts
  Future<void> fetchAndCombineCollarTShirts() async {
    final plainCollar = await fetchPlainCollarTShirts();
    final printedCollar = await fetchPrintedCollarTShirts();
 
    _allCollarTShirts = [...plainCollar, ...printedCollar];
    notifyListeners();
  }
 
  // Round Neck ================================================================================
// Plain Round Neck t-shirts
  Future<List<Product>> fetchPlainRoundNeckTShirts() async {
    QuerySnapshot plainRoundNeckTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(roundNeckTShirt)
        .collection("Plain")
        .get();
 
    return plainRoundNeckTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Printed Round Neck t-shirts
  Future<List<Product>> fetchPrintedRoundNeckTShirts() async {
    QuerySnapshot printedRoundNeckTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(roundNeckTShirt)
        .collection("Printed")
        .get();
 
    return printedRoundNeckTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Fetch and combine Round Neck t-shirts
  Future<void> fetchAndCombineRoundNeckTShirts() async {
    final plainRoundNeck = await fetchPlainRoundNeckTShirts();
    final printedRoundNeck = await fetchPrintedRoundNeckTShirts();
 
    _allRoundNeckTShirts = [...plainRoundNeck, ...printedRoundNeck];
    notifyListeners();
  }
 
  // V Neck ================================================================================
// Plain V Neck t-shirts
  Future<List<Product>> fetchPlainVNeckTShirts() async {
    QuerySnapshot plainVNeckTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(vNeckTShirt)
        .collection("Plain")
        .get();
 
    return plainVNeckTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Printed V Neck t-shirts
  Future<List<Product>> fetchPrintedVNeckTShirts() async {
    QuerySnapshot printedVNeckTShirtSnapshot = await FirebaseFirestore
        .instance
        .collection(mainCollectionName)
        .doc(menCollectionName)
        .collection(tShirtCollectionName)
        .doc(vNeckTShirt)
        .collection("Printed")
        .get();
 
    return printedVNeckTShirtSnapshot.docs
        .map((e) => Product.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }
 
  // Fetch and combine V Neck t-shirts
  Future<void> fetchAndCombineVNeckTShirts() async {
    final plainVNeck = await fetchPlainVNeckTShirts();
    final printedVNeck = await fetchPrintedVNeckTShirts();
 
    _allVNeckTShirts = [...plainVNeck, ...printedVNeck];
    notifyListeners();
  }
 
  Future<List<Product>> fetchAllTShirts() async {
    // Fetch all types of T-shirts
    await fetchAndCombineFullSleeveTShirts();
    await fetchAndCombineHalfSleeveTShirts();
    await fetchAndCombineCollarTShirts();
    await fetchAndCombineRoundNeckTShirts();
    await fetchAndCombineVNeckTShirts();
 
    // Combine all T-shirt lists into one
   _allTShirts = [
      ..._allFullSleeveTShirts,
      ..._allHalfSleeveTShirts,
      ..._allCollarTShirts,
      ..._allRoundNeckTShirts,
      ..._allVNeckTShirts,
    ];
 
    return _allTShirts;
  }
 
}
