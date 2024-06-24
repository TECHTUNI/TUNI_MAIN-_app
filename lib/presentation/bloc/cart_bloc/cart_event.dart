part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class FetchCartDataEvent extends CartEvent {}

class OnDeleteCartItem extends CartEvent {
  final String id;
  final String size;

  OnDeleteCartItem({required this.id, required this.size});
}

class AddCartItemCountEvent extends CartEvent {
  final String itemId;
  final String size;

  AddCartItemCountEvent({required this.itemId, required this.size});
}

class RemoveCartItemCountEvent extends CartEvent {
  final String itemId;
  final String size;

  RemoveCartItemCountEvent({required this.itemId, required this.size});
}

// class GetTotalProductPrice extends CartEvent {
//   final List<Map<String,dynamic>> idList;
//   GetTotalProductPrice({required this.idList});
// }

class RazorPayEventListenersEvent extends CartEvent {}

class RazorPayEvent extends CartEvent {
  final BuildContext context;
  final String name;
  final int amount;
  final String email;
  final String mobile;
  final List<CartItemModel> orderList; /////////changed
  final Map<dynamic, dynamic> address;

  RazorPayEvent(
      {required this.context,
      required this.amount,
      required this.orderList,
      required this.address,
      required this.name,
      required this.email,
      required this.mobile});
}

class CancelOrderedProductEvent extends CartEvent {
  final String orderId;
  CancelOrderedProductEvent({required this.orderId});
}
