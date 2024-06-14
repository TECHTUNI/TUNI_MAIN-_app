import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/profile/shipping_address/address_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final user = FirebaseAuth.instance.currentUser;

  AddressRepository addressRepository = AddressRepository();

  AddressBloc() : super(AddressInitial()) {
    on<OnAddAddressEvent>(_onAddAddressEvent);
    on<OnEditAddressEvent>(_onEditAddressEvent);
    on<OnDeleteAddressEvent>(_onDeleteAddressEvent);
  }

  Future<void> _onAddAddressEvent(
      OnAddAddressEvent event, Emitter<AddressState> emit) async {
    try {
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
          "Name": event.Name,
          "phone_number": event.phone_number,
          "address": event.Address1,
          "address1": event.Address2,
          "city": event.city,
         "state": event.state,
          "pincode": event.pincode,
        });
        emit(AddressAddedState());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> _onEditAddressEvent(
      OnEditAddressEvent event, Emitter<AddressState> emit) async {
      
    try {
      print('iidddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd${event.id}');
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userId = currentUser.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('address')
            .doc(event.id)
            .update({
        
          "Name": event.Name,
          "phone_number": event.phone_number,
          "address": event.Address1,
          "address1": event.Address2,
          "city": event.city,
         "state": event.state,
          "pincode": event.pincode,
        });
        emit(AddressUpdatedState());
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> _onDeleteAddressEvent(
      OnDeleteAddressEvent event, Emitter<AddressState> emit) async {
    try {
      String userId = user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('address')
          .doc(event.addressId)
          .delete();
        
      emit(AddressDeletedState());

    } catch (e) {
      return;
    }
  }
}
