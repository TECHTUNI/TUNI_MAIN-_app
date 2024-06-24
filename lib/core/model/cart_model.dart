// import 'package:cloud_firestore/cloud_firestore.dart';

// class CartModel {
//   String id;
//   dynamic image;
//   String name;
//   String price;
//   String color;
//   String size;
//   int quantity;

//   CartModel({
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.price,
//     required this.color,
//     required this.size,
//     required this.quantity,
//   });
//   factory CartModel.fromMap(Map<String, dynamic> cartData) {
//     return CartModel(
//         id: cartData['id'],
//         image: cartData['image'],
//         name: cartData['name'],
//         price: cartData['price'],
//         color: cartData['color'],
//         size: cartData['size'],
//         quantity: int.parse(cartData['itemCount']));
//   }
//   factory CartModel.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return CartModel(
//       id: data['id'],
//       image: data['image'],
//       name: data['name'],
//       price: data['price'],
//       color: data['color'],
//       size: data['size'],
//       quantity: int.parse(data['quantity']),
//     );
//   }
// }

// class CartItemModel {
//   final String? productId;
//   final String? productColor;
//   final List<String>? productImageUrl;
//   final int? productItemCountCustomer;
//   final String? productName;
//   final String? productPrice;
//   final String? productSizeCustomers;
//   final int? comboItemCountCustomer;
//   final Map<String, dynamic>? comboProductDetails;
//   final List<dynamic>? comboSelectedItems;

//   CartItemModel({
//     this.productId,
//     this.productColor,
//     this.productImageUrl,
//     this.productItemCountCustomer,
//     this.productName,
//     this.productPrice,
//     this.productSizeCustomers,
//     this.comboItemCountCustomer,
//     this.comboProductDetails,
//     this.comboSelectedItems,
//   });

//   factory CartItemModel.fromMap(Map<String, dynamic> data) {
//     return CartItemModel(
//       productId: data['id'] ?? "null",
//       productColor: data['color'] ?? "",
//       productImageUrl: List<String>.from(data['imageUrl'] ?? []),
//       productItemCountCustomer: data['itemCountcustomer'] ?? 0,
//       productName: data['name'] ?? "",
//       productPrice: data['price'] ?? "",
//       productSizeCustomers: data['sizecustomers'] ?? "",
//       comboItemCountCustomer: data['itemCountcustomer'] ?? 0,
//       comboProductDetails: data['productDetailsCombo'] ?? {},
//       comboSelectedItems: List<dynamic>.from(data['selectedItems'] ?? []),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String id;
  dynamic image;
  String name;
  String price;
  String color;
  String size;
  int quantity;

  CartModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.color,
    required this.size,
    required this.quantity,
  });

  factory CartModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CartModel(
      id: data['id'],
      image: data['image'],
      name: data['name'],
      price: data['price'],
      color: data['color'],
      size: data['size'],
      quantity: int.parse(data['quantity']),
    );
  }
}

class CartItemModel {
  final String? productId;
  final String? productColor;
  final List<String>? productImageUrl;
  final int? productItemCountCustomer;
  final String? productName;
  final String? productPrice;
  final String? productSizeCustomers;
  final String? comboDocId;
  final int? comboItemCountCustomer;
  final Map<String, dynamic>? comboProductDetails;
  final List<dynamic>? comboSelectedItems;
  final int? qunatity;

  CartItemModel({
    this.comboDocId,
    this.productId,
    this.productColor,
    this.productImageUrl,
    this.productItemCountCustomer,
    this.productName,
    this.productPrice,
    this.productSizeCustomers,
    this.comboItemCountCustomer,
    this.comboProductDetails,
    this.comboSelectedItems,
    this.qunatity,
  });

  factory CartItemModel.fromCartMap(Map<String, dynamic> data) {
    return CartItemModel(
      productId: data['id']?.isEmpty ?? true ? null : data['id'],
      productColor: data['color'] ?? "",
      productImageUrl:
          data['imageUrl'] != null ? List<String>.from(data['imageUrl']) : null,
      productItemCountCustomer: data['itemCountcustomer'] ?? 0,
      productName: data['name'] ?? "",
      productPrice: data['price'] ?? "",
      productSizeCustomers: data['sizecustomers'] ?? "",
      comboItemCountCustomer: data['itemCountcustomer'] ?? 0,
      comboProductDetails: data['productDetailsCombo'] ?? {},
      comboSelectedItems: data['selectedItems'] != null
          ? List<dynamic>.from(data['selectedItems'])
          : null,
    );
  }

  factory CartItemModel.fromComboMap(String docId, Map<String, dynamic> data) {
    return CartItemModel(
      comboDocId: docId,
      productId: data['id']?.isEmpty ?? true ? null : data['id'],
      productColor: data['color'] ?? "",
      productImageUrl:
          data['imageUrl'] != null ? List<String>.from(data['imageUrl']) : null,
      productItemCountCustomer: data['itemCountcustomer'] ?? 0,
      productName: data['name'] ?? "",
      productPrice: data['price'] ?? "",
      productSizeCustomers: data['sizecustomers'] ?? "",
      comboItemCountCustomer: data['itemCountcustomer'] ?? 0,
      comboProductDetails: data['productDetailsCombo'] ?? {},
      comboSelectedItems: data['selectedItems'] != null
          ? List<dynamic>.from(data['selectedItems'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productColor': productColor,
      'productImageUrl': productImageUrl,
      'productItemCountCustomer': productItemCountCustomer,
      'productName': productName,
      'productPrice': productPrice,
      'productSizeCustomers': productSizeCustomers,
      'comboDocId': comboDocId,
      'comboItemCountCustomer': comboItemCountCustomer,
      'comboProductDetails': comboProductDetails,
      'comboSelectedItems': comboSelectedItems,
    };
  }
}
