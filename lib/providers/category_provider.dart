import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_constants.dart';
import 'package:grocery_store/models/category_model.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class CategoryProvider with ChangeNotifier {

  bool isLoading = true;
  List<CategoryModel> _categories = [];

  List get categories => _categories;

  Future<void> getCategories() async {
    try {
      final url = Uri.parse(
          "https://online-groceries-store-nbk-default-rtdb.firebaseio.com/products/categories.json?auth=${AppConstants.token}");
      final response = await http.get(url);
      List<CategoryModel> loadedData = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData.isEmpty) {
        return;
      }

      extractedData.forEach((categoryID, category) {
        loadedData.add(
          CategoryModel(
            categoryID: categoryID,
            imageUrl: category['imageUrl'],
            title: category['title'],
            products: (category['products'] as List<dynamic>)
                .map(
                  (product) => Product(
                    productID: product['id'],
                    description: product['description'],
                    imageUrl: product['imageUrl'],
                    measure: product['measure'],
                    nutritons: product['nutrition'],
                    price: product['price'],
                    title: product['title'],
                  ),
                )
                .toList(),
          ),
        );
      });
      _categories = [];
      _categories = loadedData;
      isLoading = false;
      addProduct();
      notifyListeners();
    } on SocketException catch (error) {
      throw error;
    }
  }

  List<Product> _products = [];

  List get products => _products;

  void addProduct() {
    _products = [];
    for (int i = 0; i < _categories.length; i++) {
      _products.addAll(_categories[i].products);
    }
  }

  List<Product> searchedProducts = [];

  void searchProducts(String detail) {
    emptyList();
    searchedProducts.addAll(
      _products.where(
        (prod) => prod.title.toLowerCase().contains(detail.toLowerCase()),
      ),
    );
  }

  void emptyList(){
    searchedProducts = [];
    notifyListeners();
  }
}
