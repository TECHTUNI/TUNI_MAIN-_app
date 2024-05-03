import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuni/model/new_product%20model.dart';
import 'package:tuni/repository/product_repository.dart';

class ProdcuctProvider extends ChangeNotifier {
  List<Productdetails> _providerhalfsleve = [];
  List<Productdetails> _Allproducts = [];
  List<Productdetails> _typewise = [];

  ProductRepo productRepo = ProductRepo();
  int _selectedCategoryIndex = 0;

  int get selectedCategoryIndex => _selectedCategoryIndex;
  List<Productdetails> get providerhalfsleve => _providerhalfsleve;
  List<Productdetails> get Allproducts => _Allproducts;
  List<Productdetails> get typewise => _typewise;

  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  Future<void> gethalfsleveTshirt() async {
    try {
      List<Productdetails> newData = await productRepo.fetchTshirtshalfsleve();

      Set<String> uniqueProductIds = Set();

      _providerhalfsleve.clear();

      for (Productdetails product in newData) {
        if (!uniqueProductIds.contains(product.id)) {
          _providerhalfsleve.add(product);
          uniqueProductIds.add(product.id);
        }
      }

      // Notify listeners after updating the list
      notifyListeners();
    } catch (error) {
      print('Error fetching half sleeve t-shirts: $error');
    }
  }

  Future<void> fetchallproduct(String type, String model) async {
    try {
      List<Productdetails> allproduct =
          await productRepo.fetchALLTshirts(type, model);

      _Allproducts.clear();

      Set<String> uniqueProductIds = {};

      for (Productdetails product in allproduct) {
        if (!uniqueProductIds.contains(product.id)) {
          _Allproducts.add(product);
          uniqueProductIds.add(product.id);
        }
      }

      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }
}
