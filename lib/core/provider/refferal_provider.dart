import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RefferalProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'referrals';

  String generateRandomCode(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }

  Future<void> addReferral(Map<String, dynamic> referralData) async {
    try {
      String referralCode = generateRandomCode(8);
      referralData['referralCode'] = referralCode;
      await _firestore.collection(collectionPath).add(referralData);
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding referral: $e");
    }
  }

  Stream<QuerySnapshot> getReferrals() {
    return _firestore.collection(collectionPath).snapshots();
  }

  Future<void> deleteReferral(String docId) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete();
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting referral: $e");
    }
  }
}
