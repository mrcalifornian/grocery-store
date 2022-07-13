import 'package:flutter/material.dart';
import 'package:grocery_store/models/cart_item_model.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;
  const OrderWidget({Key? key, required this.amount, required this.dateTime, required this.products}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _isExpanded = false;
  
  void _expand(){
    setState((){
      _isExpanded = !_isExpanded;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          GestureDetector(
            onTap: _expand,
            child: ListTile(
              title: Text(
                "\$ ${(widget.amount).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.dateTime),
                  style: const TextStyle(color: Colors.black),
                ),
              trailing: Icon(_isExpanded? Icons.expand_less :Icons.expand_more),
            ),
          ),
          if(_isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: widget.products.length*20+20.0,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.products.length,
                itemBuilder: (context, index){
                  final order = widget.products[index];
                  return Row(
                    children: [
                      Text(order.title, style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      Spacer(),
                      Text("${order.quantity} x ${order.price}", style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  );
                },),
            )
        ],
      ),
    );
  }
}
