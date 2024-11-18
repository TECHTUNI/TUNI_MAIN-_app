import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuni/core/model/gp_tuni_model.dart';
import 'package:tuni/core/model/product_category_model.dart';

class GPTuniProvider with ChangeNotifier {
  List<GPTuniModel> chatMessage = [];
  List<ProductCategory> finalList = [];
  bool productsFetched = false;

  List<GPTuniModel> get messages => chatMessage;

  List<ProductCategory> get list => finalList;

  Map<String, dynamic> fetchFromFirebase = {
    "gender": "",
    "category": "",
    "type": "",
    "design": ""
  };

  GPTuniProvider() {
    addMessage(GPTuniModel(
      text: "How can I assist you?",
      isSentByMe: false,
      imageUrl: "Assets/file.jpg", // Updated asset path
      options: ["Men", "Women"],
    ));
  }

  void addMessage(GPTuniModel message) {
    chatMessage.add(message);
    notifyListeners();
  }

  void addAnswer(String answer) {
    if (productsFetched) return;

    addMessage(GPTuniModel(text: answer, isSentByMe: true));

    if (answer == "Women") {
      addMessage(GPTuniModel(
        text: "Currently we don't have women category.",
        isSentByMe: false,
        options: ["Men", "Women"],
      ));
      fetchFromFirebase["gender"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
    } else if (answer == "Men") {
      addMessage(GPTuniModel(
        text: "What are you looking for?",
        isSentByMe: false,
        options: ["Shirts", "T-shirts", "Jeans", "Sweatshirts"],
      ));
      fetchFromFirebase["gender"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
    } else if (answer == "T-shirts") {
      addMessage(GPTuniModel(
        text: "Collar, full sleeve, half sleeve, V-neck, or round neck?",
        isSentByMe: false,
        options: ["Collar", "Full sleeve", "Half sleeve", "V-neck", "Round neck"],
      ));
      fetchFromFirebase["type"] = "";
      fetchFromFirebase["design"] = "";
      fetchFromFirebase["category"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
    } else if (answer == "Jeans" || answer == "Sweatshirts") {
      addMessage(GPTuniModel(
        text: "Currently not available.",
        isSentByMe: false,
        options: ["Shirts", "T-shirts", "Jeans", "Sweatshirts"],
      ));
    } else if (answer == "Collar" ||
        answer == "Full sleeve" ||
        answer == "Half sleeve" ||
        answer == "V-neck" ||
        answer == "Round neck") {
      addMessage(GPTuniModel(
        text: "Plain or Printed?",
        isSentByMe: false,
        options: ["Plain", "Printed"],
      ));
      fetchFromFirebase["type"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
    } else if (answer == "Plain" && fetchFromFirebase["category"] == "T-shirts") {
      fetchFromFirebase["design"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
      productFetchFromFirebase();
    } 
   
    else if (answer == "Printed" && fetchFromFirebase["category"] == "T-shirts") {
      fetchFromFirebase["design"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
      productFetchFromFirebase();
    } else if (answer == "Shirts") {
      addMessage(GPTuniModel(
        text: "Full sleeve or half sleeve?",
        isSentByMe: false,
        options: ["Full sleeve", "Half sleeve"],
      ));
      fetchFromFirebase["type"] = "";
      fetchFromFirebase["design"] = "";
      fetchFromFirebase["category"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
    } else if (answer == "Full sleeve" && fetchFromFirebase["category"] == "Shirts") {
      addMessage(GPTuniModel(
        text: "Plain or Check?",
        isSentByMe: false,
        options: ["Plain", "Check"],
      ));
      fetchFromFirebase["design"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
    } else if (answer == "Half sleeve" && fetchFromFirebase["category"] == "Shirts") {
      addMessage(GPTuniModel(
        text: "Plain or Check?",
        isSentByMe: false,
        options: ["Plain", "Check"],
      ));
      fetchFromFirebase["design"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
    } else if (answer == "Plain" && fetchFromFirebase["category"] == "Shirts") {
      fetchFromFirebase["design"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
      productFetchFromFirebase();
    } else if (answer == "Check" && fetchFromFirebase["category"] == "Shirts") {
      fetchFromFirebase["design"] = answer;
      debugPrint("fetch from firebase: ${fetchFromFirebase.toString()}");
      productFetchFromFirebase();
    }
  }

  void productFetchFromFirebase() async {
    try {
      final String gender = fetchFromFirebase["gender"];
      String category = fetchFromFirebase["category"] == "Shirts" ? "Shirt" : "Tshirt";

      String type = "";
      if (fetchFromFirebase["type"] == "Collar") {
        type = "collar";
      } else if (fetchFromFirebase["type"] == "Full sleeve") {
        type = "full sleeve";
      } else if (fetchFromFirebase["type"] == "Half sleeve") {
        type = "half sleeve";
      } else if (fetchFromFirebase["type"] == "Round neck") {
        type = "round neck";
      } else if (fetchFromFirebase["type"] == "V-neck") {
        type = "v-neck";
      }

      String design = fetchFromFirebase["design"];

      debugPrint("Fetching data with:");
      debugPrint("gender: $gender");
      debugPrint("category: $category");
      debugPrint("type: $type");
      debugPrint("design: $design");

      final querySnapshot = await FirebaseFirestore.instance
          .collection("clothes")
          .doc(gender)
          .collection(category)
          .doc(type)
          .collection(design)
          .get();

      debugPrint("Number of documents fetched: ${querySnapshot.docs.length}");

      if (querySnapshot.docs.isNotEmpty) {
        finalList.clear();
        for (var doc in querySnapshot.docs) {
          final data = doc.data();
          final product = ProductCategory.fromJson(data);
          finalList.add(product);
        }
        productsFetched = true;
        notifyListeners();
      } else {
        debugPrint("No data found for the given criteria.");
      }
    } catch (e) {
      debugPrint("Failed to fetch data: $e");
    }
  }

  void resetChat() {
  debugPrint("Resetting chat...");
  chatMessage.clear();
  finalList.clear();
  productsFetched = false;
  fetchFromFirebase = {
    "gender": "",
    "category": "",
    "type": "",
    "design": ""
  };
  addMessage(GPTuniModel(
    text: "How can I assist you?",
    isSentByMe: false,
    imageUrl: "Assets/file.jpg", // Updated asset path
    options: ["Men", "Women"],
  ));
  notifyListeners();
}
}
