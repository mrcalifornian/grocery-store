import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:grocery_store/app_constants/app_constants.dart';
import 'package:grocery_store/models/product.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {

  Future<void> checkInternet() async{
    final url = Uri.parse("${AppConstants.baseUrl}products/recommended.json");
    try{
      await http.get(url);
    } on SocketException catch (error){
      throw error;
    }
  }

  // Banners
  List _banners = [];

  List get banners => _banners;

  Future<void> fetchBanners() async{
    final url = Uri.parse('${AppConstants.recommendedPrUrl}banners.json?auth=${AppConstants.token}');
    try{
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      _banners = [];
      extractedData.forEach((key, value) {
        _banners.add(value);
      });

    } catch (error) {
      throw error;
    }
  }

  // Exclusive Products
  List<Product> _exclusiveProducts = [];

  List get exclusiveProducts => _exclusiveProducts;

  Future<void> fetchExclusiveProducts() async {
    final url = Uri.parse(
        '${AppConstants.recommendedPrUrl}exclusive-products.json?auth=${AppConstants.token}');
    try {
      final response = await http.get(url);
      final List<Product> loadedProducts = [];

      final extractedProducts =
          json.decode(response.body) as Map<String, dynamic>;
      if (extractedProducts == null) {
        return;
      }

      extractedProducts.forEach((productID, product) {
        loadedProducts.add(
          Product(
            productID: productID,
            title: product['title'],
            description: product['description'],
            nutritons: (product['nutritions']).toString(),
            measure: product['measure'],
            price: product['price'],
            imageUrl: product['imageUrl'],
          ),
        );
      });
      _exclusiveProducts = [];
      _exclusiveProducts = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  //Best Selling Products
  List<Product> _bestSellingProducts = [];

  List get bestSellingProducts => _bestSellingProducts;

  Future<void> fetchBestSellingProducts() async{
    final url = Uri.parse('${AppConstants.recommendedPrUrl}best-selling.json?auth=${AppConstants.token}');
    try {
      final response = await http.get(url);

      final extractedProducts =
      json.decode(response.body) as Map<String, dynamic>;
      if (extractedProducts == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedProducts.forEach((productID, product) {
        loadedProducts.add(
          Product(
            productID: productID,
            title: product['title'],
            description: product['description'],
            nutritons: (product['nutritions']).toString(),
            measure: product['measure'],
            price: product['price'],
            imageUrl: product['imageUrl'],
          ),
        );
      });
      _bestSellingProducts = [];
      _bestSellingProducts = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  // Recommended Groceries
  List<Product> _recommendedGroceries = [];

  List get recommendedGroceries => _recommendedGroceries;

  Future<void> fetchRecommendedGroceries() async{
    final url = Uri.parse('${AppConstants.recommendedPrUrl}fresh-groceries.json?auth=${AppConstants.token}');
    try {
      final response = await http.get(url);

      final extractedProducts =
      json.decode(response.body) as Map<String, dynamic>;
      if (extractedProducts == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedProducts.forEach((productID, product) {
        loadedProducts.add(
          Product(
            productID: productID,
            title: product['title'],
            description: product['description'],
            nutritons: (product['nutritions']).toString(),
            measure: product['measure'],
            price: product['price'],
            imageUrl: product['imageUrl'],
          ),
        );
      });
      _recommendedGroceries = [];
      _recommendedGroceries = loadedProducts;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }
}
