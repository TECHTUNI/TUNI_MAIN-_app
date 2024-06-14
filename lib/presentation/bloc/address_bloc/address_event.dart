part of 'address_bloc.dart';

@immutable
abstract class AddressEvent {}

class OnAddAddressEvent extends AddressEvent {
  final String Name;
  final String phone_number;
  final String Address1;
  final String Address2;
  final String city;
  final String state;
  final String pincode;

  OnAddAddressEvent(
      { required this.Name,
        required this.phone_number,
      required this.Address1,
      required this.Address2,
      required this.city,
      required this.state,
      required this.pincode});
}

class OnEditAddressEvent extends AddressEvent {
  final String Name;
  final String phone_number;
  final String Address1;
  final String Address2;
  final String city;
  final String state;
  final String pincode;
  final String id;

  OnEditAddressEvent(
      {
        required this.Name,
        required this.phone_number,
      required this.Address1,
      required this.Address2,
      required this.city,
      required this.state,
      required this.pincode,
      required this. id,
      });

  
}

class OnDeleteAddressEvent extends AddressEvent {
  final String addressId;
final String selectedID;
  OnDeleteAddressEvent({required this.addressId,required this.selectedID});
}

class OnSelectAddressForCheckOut extends AddressEvent {

}
