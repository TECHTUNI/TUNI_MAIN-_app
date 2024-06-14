import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../core/model/address_model.dart';

class AddressRepository {
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<List<AddressModel>> fetchAddressFromFirestore() async {
    if (currentUser != null) {
      final userId = currentUser!.uid;

      if (userId.isNotEmpty) {
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('address')
            .get();
        return snapshot.docs.map((address) {
          return AddressModel(
            phonenumber: address['phone_number'],
            Adress1: address['address'],
            Adress2: address['address1'],
              city: address['city'],
              State: address['state'],
              pincode: address['pincode'], );
        }).toList();
      }
    }

    return [];
  }
}


