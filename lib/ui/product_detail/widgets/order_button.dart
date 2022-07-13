import 'package:flutter/material.dart';
import 'package:grocery_store/ui/cart_page/cart_page.dart';
import 'package:grocery_store/ui/cart_page/success_page.dart';
import 'package:grocery_store/ui/orders_page/orders_page.dart';
import 'package:provider/provider.dart';

import '../../../app_constants/app_colors.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/orders_provider.dart';
import '../../widgets/app_button.dart';

class CartButton extends StatefulWidget {
  const CartButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool isLoading = false;

  void errorDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Image.asset(
              'assets/images/bag.png'
          ),
          content: Text(
                'Oops! Order Failed',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          actions: [
            Column(
              children: [
                    const Text(
                  'Something went wrong \nTry again later!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                AppButton(
                    height: 60,
                    color: Colors.white,
                    name: 'Back',
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          await Provider.of<OrdersProvider>(context, listen: false)
              .addOrder(widget.cart.cartItems.values.toList(),
              widget.cart.totalAmount)
              .then((value) => {
                Provider.of<CartProvider>(context, listen: false).clear(),
            setState(() {
              isLoading = false;
            }),
            Navigator.pushReplacementNamed(context, SuccessPage.routeName),
          })
              .catchError((error) {
            setState(() {
              isLoading = false;
            });
            errorDialog();
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.mainGreen,
          ),
          child: isLoading
              ? const Center(
            child: CircularProgressIndicator(color: Colors.white),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Go to Checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                "\$ ${(widget.cart.totalAmount).toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}