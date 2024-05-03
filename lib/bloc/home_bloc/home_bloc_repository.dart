import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuni/model/new_product%20model.dart';

import '../../model/product_model.dart';

class HomeRepository {
  List<Productdetails> products = [];

  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection("Clothes");

  final user = FirebaseAuth.instance.currentUser;
  CollectionReference<Map<String, dynamic>>? favoriteCollection;

  Future<List<Product>> fetchDataFromFirestore() async {
    QuerySnapshot snapshot = await dataCollection.get();
    return snapshot.docs.map((product) {
      return Product(
        id: product['id'],
        name: product['name'],
        gender: product['gender'],
        category: product['category'],
        brand: product['brand'],
        price: product['price'],
        imageUrl: product['imageUrl'] ?? '',
        time: product['time'],
        size: product['size'],
        quantity: product['Quantity'] ?? 0,
        color: product['color'],
      );
    }).toList();
  }

  Future<void> addProductToCart({
    required String id,
    required String name,
    required List image,
    required String price,
    required String color,
    required String itemCount,
    required String selectedSize,
  }) async {
    final userId = user?.uid;
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    Map<String, dynamic> cartData = {
      "id": id,
      "image": image,
      "name": name,
      "price": price,
      "color": color,
      "itemCount": itemCount,
      "size": selectedSize
    };
    users.doc(userId).collection("cartCollection").doc(id).set(cartData);
  }

  Future<List<Productdetails>> fetchallProducts() async {
    try {
      // Define arrays for collections and documents
      List<String> genderList = ["Men", "Women", "Kids"];
      List<String> categoryList = ["Shirt", "Pant", "T-shirt", "Shorts"];
      List<String> typeList = [
        "full sleve",
        "half sleve",
        "collar",
        "round neck",
        "v-neck"
      ];
      List<String> designList = ["Plain", "Printed", "check"];

      // Iterate through each combination of collections and documents
      for (String gender in genderList) {
        for (String category in categoryList) {
          for (String type in typeList) {
            for (String design in designList) {
              // Construct the Firestore path
              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection("clothes")
                  .doc(gender)
                  .collection(category)
                  .doc(type)
                  .collection(design)
                  .get();

              // Process the documents in the query snapshot
              querySnapshot.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                Productdetails product = Productdetails(
                  id: data['id'].toString(),
                  name: data['name'].toString(),
                  brand: data['brand'].toString(),
                  gender: data['gender'].toString(),
                  price: data['price'].toString(),
                  time: data['time'].toString(),
                  imageUrlList: List<String>.from(data['imageUrl'] ?? []),
                  quantity: data['Quantity'].toString(),
                  color: data['color'].toString(),
                  size: List<String>.from(data['size'] ?? []),
                );
                products.add(product);
                for (int i = 0; i <= products.length; i++) {
                  print(product.name);
                }
              });
            }
          }
        }
      }

      return products;
    } catch (e) {
      print("Error fetching products: $e");
      throw e; // Rethrow the error to handle it in the calling code
    }
  }
}
