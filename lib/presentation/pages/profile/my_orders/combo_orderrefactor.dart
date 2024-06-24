import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuni/presentation/pages/profile/my_orders/combo_order_details.dart';
import 'package:tuni/presentation/pages/profile/my_orders/product_order_details.dart';

class DividerLineForCupertino extends StatelessWidget {
  const DividerLineForCupertino({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: .1)),
    );
  }
}

class AddressHeadingInOrderDetails extends StatelessWidget {
  final String text;

  const AddressHeadingInOrderDetails({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString().toUpperCase(),
      style: const TextStyle(
        fontSize: 18,
        letterSpacing: 1,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class ComboViewInMyOrders extends StatelessWidget {
  const ComboViewInMyOrders({
    super.key,
    required this.orderId,
    required this.address,
    required this.screenWidth,
    // required this.comboThumbnailImage,
    // required this.comboName,
    required this.orderStatus,
    required this.selectedItems,
    required this.productDetailsCombo,
  });

  final String orderId;
  final Map<String, dynamic>? address;
  final double screenWidth;
  final List<Map<String, dynamic>>? selectedItems;
  final Map<String, dynamic>? productDetailsCombo;
  final bool? orderStatus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ComboOrderDetailPage(
              orderId: orderId,
              selectedItems: selectedItems,
              address: address!,
              productDetailsCombo: productDetailsCombo,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        child: Container(
          height: screenWidth * .25,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(),
          decoration: const BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 0.5, color: CupertinoColors.systemGrey)),
          ),
          child: Row(
            children: [
              Container(
                height: screenWidth * .2,
                width: screenWidth * .15,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(productDetailsCombo?["tumbnail"]),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productDetailsCombo?["name"],
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    orderId,
                    style: TextStyle(
                        letterSpacing: 1,
                        color: CupertinoColors.black.withOpacity(0.8)),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    orderStatus == false ? "Processing" : "Order Placed",
                    style: const TextStyle(
                        letterSpacing: 1, color: CupertinoColors.systemGrey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsViewInMyOrders extends StatelessWidget {
  const ProductsViewInMyOrders({
    super.key,
    required this.orderId,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    required this.address,
    required this.screenWidth,
    required this.orderStatus,
  });

  final String orderId;

  final dynamic imageUrl;
  final String? productName;
  final String? productPrice;
  final Map<String, dynamic>? address;
  final double screenWidth;
  final bool? orderStatus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ProductsOrderDetailPage(
              orderId: orderId,
              imageUrl: imageUrl,
              productName: productName,
              productPrice: productPrice,
              address: address!,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        child: Container(
          height: screenWidth * .25,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(),
          decoration: const BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 0.5, color: CupertinoColors.systemGrey)),
          ),
          child: Row(
            children: [
              Container(
                height: screenWidth * .2,
                width: screenWidth * .15,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productName!,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    orderId,
                    style: TextStyle(
                        letterSpacing: 1,
                        color: CupertinoColors.black.withOpacity(0.8)),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    orderStatus == false ? "Processing" : "Order Placed",
                    style: const TextStyle(
                        letterSpacing: 1, color: CupertinoColors.systemGrey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
