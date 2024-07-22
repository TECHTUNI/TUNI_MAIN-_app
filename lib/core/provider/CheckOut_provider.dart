import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/model/cart_model.dart';
import '../../presentation/pages/bottom_nav/pages/bottom_nav_bar_page.dart';

class CheckOutProvider extends ChangeNotifier {
  final Razorpay _razorpay = Razorpay();
  final TextEditingController _referralCodeController = TextEditingController();
  String? referralError;
  List<Map<String, dynamic>>? referralDetails;

  String _refferal_code = '';

  String get refferal_code => _refferal_code;

  TextEditingController get referralCodeController => _referralCodeController;

  void dispose() {
    _razorpay.clear();
    _referralCodeController.dispose();
    super.dispose();
  }

  Future<void> razorPayCheckout({
    required int amount,
    required Map<String, dynamic> address,
    required List<CartItemModel> orderList,
    required int total,
    required List<String> ids,
    required BuildContext context,
  }) async {
    try {
      Map<String, dynamic> options = {
        'key': 'rzp_live_W0t2SeLjFxX8SB',
        //  "rzp_test_TpsHVKhrkZuIUJ",
        // replace with your actual Razorpay key
        'amount': amount * 100,
        'name': 'Tuni',
        'description': 'Payment for TUNi',
        'timeout': 300,
        'prefill': {
          'contact': '8088473612',
          'email': 'tunitechsolution@gmail.com'
        },
      };

      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) {
        checkOut(
                orderList: orderList,
                address: address,
                totalPrice: total,
                ids: ids,
                referralCode: refferal_code)
            .then((value) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => const BottomNavBarPage()),
            (route) => false,
          );
        });
        // debugPrint("${_storedReferralCode.toString()} 2");
      });

      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
        // Handle payment error
      });

      _razorpay.open(options);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> handleReferralCodeSubmit() async {
    referralError = null;
    referralDetails = null;

    final String referralCode = _referralCodeController.text;

    if (referralCode.isEmpty) {
      referralError = "Please enter a referral code.";
      notifyListeners();
      return;
    }

    try {
      // Fetch referral details from Firestore
      DocumentReference referralDocRef =
          FirebaseFirestore.instance.collection('referrals').doc(referralCode);
      QuerySnapshot querySnapshot =
          await referralDocRef.collection('personal_details').get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> userDetailsList = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        if (userDetailsList.any((detail) =>
            detail['userId'] == FirebaseAuth.instance.currentUser!.uid)) {
          debugPrint("You cannot use your own referral code.");
          referralError = "You cannot use your own referral code.";
          notifyListeners();
        } else {
          referralDetails = userDetailsList;
          notifyListeners();

          // Send notification
          final response = await http.post(
            Uri.parse(
                'https://us-central1-tunitest-e022d.cloudfunctions.net/sockets/sendNotification'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'referralCode': referralCode,
              'userDetailsList': userDetailsList,
            }),
          );

          final responseData = json.decode(response.body);
          if (responseData['success']) {
            print("Notifications sent successfully");
          } else {
            print("Error sending notifications: ${responseData['error']}");
          }
        }
      } else {
        referralError = "Referral code not found.";
        notifyListeners();
      }
    } catch (e) {
      referralError =
          "Error fetching referral details. Please try again later.";
      notifyListeners();
      print("Error fetching referral details: $e");
    }
  }

  Future<void> checkOut(
      {required List<CartItemModel> orderList,
      required Map<String, dynamic> address,
      required int totalPrice,
      required List<String> ids,
      String? referralCode}) async {
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

    for (var combo in orderedComboList) {
      if (combo['comboProductDetails'] != null) {
        comboProductDetails =
            combo['comboProductDetails'] as Map<String, dynamic>;
        // debugPrint("comboProductDetails: $comboProductDetails");
        // comboSelectedItems = combo['comboSelectedItems'];
        // debugPrint("comboProductDetails: $comboSelectedItems");
      }
    }

    if (refferal_code.isNotEmpty) {
      debugPrint("not empty");
      debugPrint("referral code in if condintion: $refferal_code");
      try {
        CollectionReference collectionRef = FirebaseFirestore.instance
            .collection('referrals')
            .doc(refferal_code)
            .collection('Use_Referal_Count');

        // Get the QuerySnapshot by awaiting the Future
        QuerySnapshot querySnapshot = await collectionRef.get();

        if (querySnapshot.docs.isNotEmpty) {
          for (var doc in querySnapshot.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            int count = data['count'];
            // String referralCode = data['referralCode'];
            // int rewardAmount = data['rewardAmount'];
            String docId = doc.id;

            int newCount = count + 1;
            int newRewardAmount = newCount * 250;

            collectionRef
                .doc(docId)
                .update({"count": newCount, "rewardAmount": newRewardAmount});
          }
        } else {
          print('No documents found.');
        }
      } catch (error) {
        print('Error fetching document: $error');
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

  Future<void> applayrefferal(String refferal_To_code) async {
    _refferal_code = refferal_To_code;
  }
}
