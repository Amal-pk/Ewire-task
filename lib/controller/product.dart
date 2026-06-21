import 'package:ewire_task/models/product.dart';
import 'package:ewire_task/service/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<ProductModel> products = [];

  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getProducts();

      products = response;
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
