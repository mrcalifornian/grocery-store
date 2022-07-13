import 'package:flutter/material.dart';
import 'package:grocery_store/models/product.dart';
import 'package:hive/hive.dart';

import '../app_constants/app_constants.dart';
import '../models/cart_item_model.dart';

class CartProvider with ChangeNotifier {

  // Map<String, CartItem> _cartItems = {};

  Box<CartItem> get cartBox => Hive.box<CartItem>(AppConstants.cartBox);

  Map<dynamic, CartItem> get cartItems => cartBox.toMap();

  double get totalAmount {
    var total = 0.0;
    cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (cartBox.containsKey(product.productID)) {
      removeItem(product.productID);
    } else {
      cartBox.put(product.productID,
        CartItem(
          id: product.productID,
          title: product.title,
          measure: product.measure,
          imageUrl: product.imageUrl,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void increaseQuantity(CartItem product, int index) {
    cartBox.putAt(index,
      CartItem(
        id: product.id,
        title: product.title,
        measure: product.measure,
        imageUrl: product.imageUrl,
        quantity: product.quantity+1,
        price: product.price,
      ),);
    notifyListeners();
  }

  void decreaseQuantity(CartItem product, int index) {
    cartBox.putAt(index,
      CartItem(
        id: product.id,
        title: product.title,
        measure: product.measure,
        imageUrl: product.imageUrl,
        quantity: product.quantity <= 1 ? 1 : product.quantity - 1,
        price: product.price,
      ),);
    notifyListeners();
  }



  void removeItem(String productID) {
    cartBox.delete(productID);
    notifyListeners();
  }

  void clear() {
    cartBox.clear();
    notifyListeners();
  }

}
