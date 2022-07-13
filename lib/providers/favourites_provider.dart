import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../app_constants/app_constants.dart';
import '../models/product.dart';

class FavouritesProvider with ChangeNotifier {
  List<Product> _list = [
    Product(
      productID: "11144",
      title: 'Title',
      description: 'description',
      nutritons: 'nutritons',
      measure: '1kg',
      price: 3.44,
      imageUrl:
          'https://raw.githubusercontent.com/nodirbektojiboev/test-mode/main/grocery-store/category-fruits.png',
    )
  ];

  Box<Product> get favBox => Hive.box<Product>(AppConstants.favBox);

  List<Product> get list => favBox.toMap().values.toList();

  Future<void> addProduct(Product product) async {

    if(favBox.containsKey(product.productID)){
      favBox.delete(product.productID);
    } else {
      favBox.put(
        product.productID,
        Product(
          productID: product.productID,
          title: product.title,
          description: product.description,
          nutritons: product.nutritons,
          measure: product.measure,
          price: product.price,
          imageUrl: product.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> deleteProduct(int index) async{
    await favBox.deleteAt(index);
    notifyListeners();
  }
}
