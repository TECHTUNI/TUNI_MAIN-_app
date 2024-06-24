class OrderHistoryModel {
  final String? orderId;
  final bool? orderStatus;
  final Map<String, dynamic>? orderAddress;
  final Map<String, dynamic>? productDetailsCombo;
  final List<Map<String, dynamic>>? selectedItems;
  final int? totalPrice;
  final int? itemCountCustomer;
  final String? productColor;
  final String? productId;
  final List<dynamic>? productImageUrl;
  final String? productName;
  final String? productPrice;
  final String? sizeCustomers;

  OrderHistoryModel({
    this.orderId,
    this.orderStatus,
    this.orderAddress,
    this.productDetailsCombo,
    this.selectedItems,
    this.totalPrice,
    this.itemCountCustomer,
    this.productColor,
    this.productId,
    this.productImageUrl,
    this.productName,
    this.productPrice,
    this.sizeCustomers,
  });

  factory OrderHistoryModel.fromMap(Map<String, dynamic> data) {
    return OrderHistoryModel(
      orderId: data['orderID'] as String?,
      orderStatus: data['orderStatus'] as bool?,
      orderAddress: data['orderAddress'] as Map<String, dynamic>?,
      productDetailsCombo: data['productDetailsCombo'] as Map<String, dynamic>?,
      selectedItems: data['selectedItems'] != null
          ? List<Map<String, dynamic>>.from(data['selectedItems'])
          : null,
      totalPrice: data['totalPrice'] as int?,
      itemCountCustomer: data['itemCountcustomer'] as int?,
      productColor: data['color'] as String?,
      productId: data['id'] as String?,
      productImageUrl: data['imageUrl'] as List<dynamic>?,
      productName: data['name'] as String?,
      productPrice: data['price'] as String?,
      sizeCustomers: data['sizeCustomers'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderID': orderId,
      'orderStatus': orderStatus,
      'orderAddress': orderAddress,
      'productDetailsCombo': productDetailsCombo,
      'selectedItems': selectedItems,
      'totalPrice': totalPrice,
      'itemCountcustomer': itemCountCustomer,
      'productColor': productColor,
      'productId': productId,
      'productImageUrl': productImageUrl,
      'productName': productName,
      'productPrice': productPrice,
      'sizeCustomers': sizeCustomers,
    };
  }
}
