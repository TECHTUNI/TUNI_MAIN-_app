import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuni/model/new_product model.dart'; // Ensure this import is correct based on your file structure

class ProductRepo {
  List<Productdetails> fullTshirt = [];
  List<Productdetails> halfsleve = [];
  List<Productdetails> Typewise = [];

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
  Future<List<Productdetails>> fetchALLTshirts(
      String type, String model) async {
    Set<String> productIds = {};
    List<Productdetails> allTshirts = [];

    try {
      // for (String gender in gendersList) {
      // for (String itemType in itemTypesList) {

      for (String dsgn in design) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("clothes")
            .doc('Men')
            .collection(type)
            .doc(model)
            .collection(dsgn)
            .get();

        querySnapshot.docs.forEach((doc) {
          print(querySnapshot.docs);
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Productdetails product = Productdetails.fromJson(data);

          // Check if the product ID is already added
          if (!productIds.contains(product.id)) {
            allTshirts.add(product);
            productIds.add(product.id);
          }
        });

        // }
        // }
      }

      // Return the list of all T-shirts
      return allTshirts;
    } catch (e) {
      print('Error fetching T-shirts: $e');
      throw e;
    }
  }

  Future<List<Productdetails>> fetchTshirtsTypewise(
      String type, String model) async {
    // Typewise.clear();

    try {
      print('hiiiiiiiiiiiiiiii');

      for (String gender in gendersList) {
        for (String desing in design) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection("clothes")
              .doc(gender)
              .collection(model)
              .doc(type)
              .collection(desing)
              .get();
          // Process the retrieved documents
          querySnapshot.docs.forEach((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            Productdetails product = Productdetails.fromJson(data);
            Typewise.add(product);
          });
        }
      }

      return halfsleve;
    } catch (e) {
      print('Error fetching T-shirts: $e');

      throw e;
    }
  }

  Future<List<Productdetails>> fetchTshirtshalfsleve() async {
    halfsleve.clear();

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

              // Process the retrieved documents
              querySnapshot.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                Productdetails product = Productdetails.fromJson(data);

                halfsleve.add(product);
              });
            }
          }
        }
      }
      return halfsleve;
    } catch (e) {
      print('Error fetching T-shirts: $e');

      throw e;
    }
  }

  Future<void> fetchcollarTshirts() async {
    fullTshirt.clear();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("clothes")
          .doc("Men")
          .collection("Tshirt")
          .doc("collar")
          .collection("Plain")
          .get();

      // Process the retrieved documents
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Productdetails product = Productdetails.fromJson(data);
        // Tshirt.clear();
        fullTshirt.add(product);
      });
    } catch (e) {
      print('Error fetching T-shirts: $e');

      throw e;
    }
  }

  Future<void> fetchroundTshirts() async {
    fullTshirt.clear();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("clothes")
          .doc("Men")
          .collection("Tshirt")
          .doc("round neck")
          .collection("Plain")
          .get();

      // Process the retrieved documents
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Productdetails product = Productdetails.fromJson(data);
        // Tshirt.clear();
        fullTshirt.add(product);
      });
    } catch (e) {
      print('Error fetching T-shirts: $e');

      throw e;
    }
  }
}
