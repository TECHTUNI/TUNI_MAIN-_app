import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuni/core/model/product_category_model.dart';
import 'package:tuni/presentation/pages/combo/combo_detail_page.dart';

class ProductRepo {
  List<ProductCategory> fullTShirt = [];
  List<ProductCategory> halfSleeve = [];
  List<ProductCategory> typeWise = [];
  List<ComboDetailPage> comboProducts = []; // List for combo products

  List<String> itemTypesList = ["Pant", "Shirt", "Tshirt", "Shorts"];
  List<String> gendersList = [
    "Men",
    "Women",
  ];
  final List<String> pants = ["Jogger", "Six pocket", "Jeans"];
  final List<String> types = [
    "full sleve",
    "half sleve",
    "collar",
    "round neck",
    "v-neck"
  ];
  final List<String> design = ["Plain", "Printed", "check"];

  Future<List<ProductCategory>> fetchALLTshirts(
      String type, String model) async {
    Set<String> productIds = {};
    List<ProductCategory> allTShirts = [];

    try {
      for (String dsgn in design) {
        // for (String type in types) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("clothes")
            .doc('Men')
            .collection(type)
            .doc(model)
            .collection(dsgn)
            .get();

        querySnapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          ProductCategory product = ProductCategory.fromJson(data);

          if (!productIds.contains(product.id)) {
            allTShirts.add(product);
            productIds.add(product.id);
          }
        });
      }
      // }

      return allTShirts;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ProductCategory>> fetchTshirtsTypewise(
      String type, String model) async {
    // Typewise.clear();

    try {
      for (String gender in gendersList) {
        for (String desing in design) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection("clothes")
              .doc(gender)
              .collection(model)
              .doc(type)
              .collection(desing)
              .get();
          querySnapshot.docs.forEach((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            ProductCategory product = ProductCategory.fromJson(data);
            typeWise.add(product);
          });
        }
      }

      return halfSleeve;
    } catch (e) {
      print('Error fetching T-shirts: $e');

      throw e.toString();
    }
  }

  Future<List<ProductCategory>> fetchTshirtshalfsleve() async {
    halfSleeve.clear();

    try {
      for (String gender in gendersList) {
        for (String iteam in itemTypesList) {
          for (String type in types) {
            for (String desing in design) {
              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection("clothes")
                  .doc(gender)
                  .collection(iteam)
                  .doc(type)
                  .collection(desing)
                  .get();

              querySnapshot.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                ProductCategory product = ProductCategory.fromJson(data);

                halfSleeve.add(product);
              });
            }
          }
        }
      }
      return halfSleeve;
    } catch (e) {
      debugPrint('Error fetching T-shirts: $e');

      throw e.toString();
    }
  }

  Future<void> fetchcollarTshirts() async {
    fullTShirt.clear();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("clothes")
          .doc("Men")
          .collection("Tshirt")
          .doc("collar")
          .collection("Plain")
          .get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        ProductCategory product = ProductCategory.fromJson(data);
        // Tshirt.clear();
        fullTShirt.add(product);
      });
    } catch (e) {
      print('Error fetching T-shirts: $e');

      throw e;
    }
  }

  Future<void> fetchroundTshirts() async {
    fullTShirt.clear();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("clothes")
          .doc("Men")
          .collection("Tshirt")
          .doc("round neck")
          .collection("Plain")
          .get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        ProductCategory product = ProductCategory.fromJson(data);
        // Tshirt.clear();
        fullTShirt.add(product);
      });
    } catch (e) {
      debugPrint('Error fetching T-shirts: $e');

      throw e.toString();
    }
  }

// }
  Future<List<ComboDetailPage>> fetchComboProducts() async {
    comboProducts.clear();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              "combo_products") // Replace with your collection name for combo products
          .get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        ComboDetailPage comboProduct = ComboDetailPage.fromJson(data);
        print(comboProduct.comboName);

        comboProducts.add(comboProduct);
      });

      return comboProducts;
    } catch (e) {
      print('Error fetching combo products: $e');
      throw e.toString();
    }
  }
}
