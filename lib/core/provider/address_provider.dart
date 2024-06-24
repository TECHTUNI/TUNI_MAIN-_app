import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AddressProvider extends ChangeNotifier {
  void addAddressToFirestore({
    required TextEditingController nameController,
    required TextEditingController phoneNumberController,
    required TextEditingController addressLineOneController,
    required TextEditingController addressLineTwoController,
    required TextEditingController cityController,
    required TextEditingController stateController,
    required TextEditingController pinCodeController,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        final String id = DateTime.now().millisecondsSinceEpoch.toString();
        CollectionReference collectionReference = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('address');
        await collectionReference.doc(id).set({
          "id": id,
          "Name": nameController.text,
          "phone_number": phoneNumberController.text,
          "address": addressLineOneController.text,
          "address1": addressLineTwoController.text,
          "city": cityController.text,
          "state": stateController.text,
          "pincode": pinCodeController.text,
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  void updateAddressAtFirestore({
    required String addressId,
    required TextEditingController nameController,
    required TextEditingController phoneNumberController,
    required TextEditingController addressLineOneController,
    required TextEditingController addressLineTwoController,
    required TextEditingController cityController,
    required TextEditingController stateController,
    required TextEditingController pinCodeController,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('address')
            .doc(addressId)
            .update({
          "id": addressId,
          "Name": nameController.text,
          "phone_number": phoneNumberController.text,
          "address": addressLineOneController.text,
          "address1": addressLineTwoController.text,
          "city": cityController.text,
          "state": stateController.text,
          "pincode": pinCodeController.text,
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> fetchAddress() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("address")
        .get();

    List<String> documentIds = snapshot.docs.map((doc) => doc.id).toList();
    debugPrint(documentIds.toString());
  }
}
