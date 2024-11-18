import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuni/core/model/Order_history_model.dart';
import 'package:tuni/core/provider/Order_Histroy_Provider.dart';
import 'package:tuni/presentation/pages/profile/my_orders/combo_orderrefactor.dart';

class UserOrders extends StatelessWidget {
  UserOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final orderHistoryProvider =
        Provider.of<OrderHistoryProvider>(context, listen: false);

    // Fetch order history items when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderHistoryProvider.fetchOrderHistoryItems(userId: userId);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Consumer<OrderHistoryProvider>(
        builder: (context, provider, child) {
          if (provider.orderHistoryItems.isEmpty) {
            // Show shimmer effect while loading
            return _buildShimmerEffect(screenWidth);
          } else {
            // Show actual order history items
            return ListView.builder(
              itemCount: provider.orderHistoryItems.length,
              itemBuilder: (context, index) {
                final OrderHistoryModel order =
                    provider.orderHistoryItems[index];

                final orderId = order.orderId!;
                final productName = order.productName;
                final productPrice = order.productPrice;
                final address = order.orderAddress;
                final orderStatus = order.orderStatus;
                final formattedDate =
                    order.orderAddress!['orderDateFormatted'] ?? '';
                final imageUrl = order.productImageUrl?[0];
                final comboThumbnailImage =
                    order.productDetailsCombo?["tumbnail"];
                final comboName = order.productDetailsCombo?["name"];
                final selectedItems = order.selectedItems;

                if (imageUrl != null) {
                  return ProductsViewInMyOrders(
                    orderId: orderId,
                    imageUrl: imageUrl,
                    productName: productName,
                    productPrice: productPrice,
                    address: address,
                    screenWidth: screenWidth,
                    orderStatus: orderStatus,
                  );
                } else {
                  return ComboViewInMyOrders(
                    orderId: orderId,
                    address: address,
                    screenWidth: screenWidth,
                    // comboThumbnailImage: comboThumbnailImage,
                    // comboName: comboName,
                    orderStatus: orderStatus,
                    selectedItems: selectedItems,
                    productDetailsCombo: order.productDetailsCombo,
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildShimmerEffect(double screenWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(seconds: 2),
      child: ListView.builder(
        itemCount: 5, // Placeholder for shimmer effect
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 56,
              height: 56,
              color: Colors.white,
            ),
            title: Container(
              height: 16,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 16,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
