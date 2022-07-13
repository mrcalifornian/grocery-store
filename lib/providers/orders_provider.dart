import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_constants.dart';
import 'package:http/http.dart' as http;
import '../models/cart_item_model.dart';
import '../models/order_item_model.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => _orders;

  final url = Uri.parse(
      '${AppConstants.baseUrl}users/${AppConstants.userID}/orders.json?auth=${AppConstants.token}');

  Future<void> getOrders() async {
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      List<OrderItem> loadedOrders = [];
      extractedData.forEach((id, data) {
        loadedOrders.insert(
          0,
          OrderItem(
            id: id,
            amount: data['amount'],
            products: (data['products'] as List<dynamic>)
                .map(
                  (prod) => CartItem(
                    id: prod['id'],
                    title: prod['title'],
                    measure: prod['measure'],
                    imageUrl: '',
                    quantity: prod['quantity'],
                    price: prod['price'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(
              data['dateTime'],
            ),
          ),
        );
      });
      _orders = loadedOrders;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartItems, double totalAmount) async {
    final dateTime = DateTime.now();

    try {
      await http
          .post(
            url,
            body: json.encode(
              {
                'amount': totalAmount,
                'dateTime': dateTime.toIso8601String(),
                'products': cartItems
                    .map(
                      (product) => {
                        'id': product.id,
                        'title': product.title,
                        'quantity': product.quantity,
                        'measure': product.measure,
                        'price': product.price,
                      },
                    )
                    .toList(),
              },
            ),
          )
          .then(
            (value) => {
              _orders.insert(
                0,
                OrderItem(
                  id: json.decode(value.body)['name'],
                  amount: totalAmount,
                  products: cartItems,
                  dateTime: dateTime,
                ),
              ),
            },
          );
    } catch (error) {
      throw error;
    }
  }
}
