import 'package:flutter/material.dart';
import '../model/combo_model.dart';

class SelectedProductProvider extends ChangeNotifier {
  ComboProductListModel? _selectedProduct;

  ComboProductListModel? get selectedProduct => _selectedProduct;

  void setSelectedProduct(ComboProductListModel? product) {
    _selectedProduct = product;
    notifyListeners();
  }
}
