import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReferralProvider with ChangeNotifier {
  String? referralCode;
  int rewardAmount = 0;
  bool isLoading = true;

  Future<void> fetchReferralData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Fetch referral code
      final referralSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("personal_details")
          .doc("details")
          .get();

      if (referralSnapshot.exists) {
        referralCode = referralSnapshot.data()!["referralCode"];
      }

      // Fetch reward amount
      if (referralCode != null) {
        final referralCountSnapshot = await FirebaseFirestore.instance
            .collection("referrals")
            .doc(referralCode)
            .collection("Use_Referal_Count")
            .limit(1)
            .get();

        if (referralCountSnapshot.docs.isNotEmpty) {
          final document = referralCountSnapshot.docs.first;
          rewardAmount = document["rewardAmount"] ?? 0;
        }
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error fetching referral data: $e');
      isLoading = false;
      notifyListeners();
    }
  }
}
