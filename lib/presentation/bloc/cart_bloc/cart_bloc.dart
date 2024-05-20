import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tuni/presentation/pages/profile/my_orders/user_orders.dart';
import '../../../core/model/cart_model.dart';
import '../../../core/model/product_order_model.dart';
import '../../pages/bottom_nav/pages/bottom_nav_bar_page.dart';
import 'cart_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository = CartRepository();

  final User? user = FirebaseAuth.instance.currentUser;
  final Razorpay _razorpay = Razorpay();

  int totalAmount = 0;

  CartBloc() : super(CartInitial()) {
    on<FetchCartDataEvent>(fetchCartDataEvent);
    on<OnDeleteCartItem>(onDeleteCartItem);
    on<AddCartItemCountEvent>(addCartItemCountEvent);
    on<RemoveCartItemCountEvent>(removeCartItemCountEvent);

    on<RazorPayEvent>(razorPayEvent);
    on<CancelOrderedProductEvent>(cancelOrderedProductEvent);
  }

  FutureOr<void> fetchCartDataEvent(
      FetchCartDataEvent event, Emitter<CartState> emit) async {
    try {
      final int total = await cartRepository.getCartTotal();
      final List<CartModel> cartDataList =
          await cartRepository.fetchCartDataFromFirestore();
      emit(CartDataFetchedState(
          cartDataList: cartDataList, cartTotalPrice: total));
    } catch (e) {
      throw e.toString();
    }
  }

  FutureOr<void> onDeleteCartItem(
      OnDeleteCartItem event, Emitter<CartState> emit) async {
    try {
      await cartRepository.deleteCartItem(event.id, event.size);
      emit(CartItemDeletedState());
      final int total = await cartRepository.getCartTotal();
      final List<CartModel> cartDataList =
          await cartRepository.fetchCartDataFromFirestore();
      emit(CartDataFetchedState(
          cartDataList: cartDataList, cartTotalPrice: total));
    } catch (e) {
      throw e.toString();
    }
  }

  FutureOr<void> addCartItemCountEvent(
      AddCartItemCountEvent event, Emitter<CartState> emit) async {
    print('hiiii');
    try {
      cartRepository.addCartItemCount(event.itemId, event.size);
      emit(CartActionSuccessState());
      int total = await cartRepository.getCartTotal();
      final List<CartModel> cartDataList =
          await cartRepository.fetchCartDataFromFirestore();
      emit(CartDataFetchedState(
          cartDataList: cartDataList, cartTotalPrice: total));
    } catch (e) {
      throw e.toString();
    }
  }

  FutureOr<void> removeCartItemCountEvent(
      RemoveCartItemCountEvent event, Emitter<CartState> emit) async {
    try {
      cartRepository.lessCartItemCount(event.itemId, event.size);
      emit(CartActionSuccessState());
      int total = await cartRepository.getCartTotal();
      final List<CartModel> cartDataList =
          await cartRepository.fetchCartDataFromFirestore();
      emit(CartDataFetchedState(
          cartDataList: cartDataList, cartTotalPrice: total));
    } catch (e) {
      throw e.toString();
    }
  }

  FutureOr<void> razorPayEventListenersEvent(
      RazorPayEventListenersEvent event, Emitter<CartState> emit) async {}

  FutureOr<void> razorPayEvent(
      RazorPayEvent event, Emitter<CartState> emit) async {
    try {
      Map<String, dynamic> options = {
        'key':
            //  ' rzp_test_TpsHVKhrkZuIUJ',
            'rzp_live_W0t2SeLjFxX8SB',
        'amount': event.amount * 100,
        'name': 'Tuni',
        'description': 'Payment for tuni',
        'timeout': 300,
        'prefill': {
          'contact': '8088473612',
          'email': 'tunitechsolution@gmail.com'
        }
      };
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
          (PaymentSuccessResponse response) {
        cartRepository.addOrderListInFirestore(
            context: event.context,
            name: event.name,
            email: event.email,
            address: event.address,
            mobile: event.mobile,
            orderList: event.orderList);
        Navigator.pushReplacement(event.context,
            MaterialPageRoute(builder: (context) => UserOrders()));
      });

      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
          (PaymentFailureResponse response) {
        Navigator.pushAndRemoveUntil(
            event.context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBarPage(),
            ),
            (route) => false);
        showDialog(
          context: event.context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Can't checkout, please try again!!"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            );
          },
        );
      });

      _razorpay.on(
          Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {});
      _razorpay.open(options);
    } catch (e) {
      throw e.toString();
    }
  }

  FutureOr<void> cancelOrderedProductEvent(
      CancelOrderedProductEvent event, Emitter<CartState> emit) async {
    try {
      final userId = user!.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("orderList")
          .doc(event.orderId)
          .delete();
      await FirebaseFirestore.instance
          .collection("AllOrderList")
          .doc(event.orderId)
          .delete();
    } catch (e) {
      throw e.toString();
    }
  }
}
