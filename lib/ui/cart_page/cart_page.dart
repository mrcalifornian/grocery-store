import 'package:flutter/material.dart';
import 'package:grocery_store/providers/cart_provider.dart';
import 'package:grocery_store/ui/cart_page/widgets/cart_item.dart';
import 'package:grocery_store/ui/widgets/app_button.dart';
import 'package:provider/provider.dart';
import '../product_detail/widgets/order_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static String routeName = '/cart-page';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: cart.totalAmount == 0? 1: 0,
        title: const Center(
          child: Text("My Cart"),
        ),
      ),
      body: cart.totalAmount <= 0
          ? Center(child: Image.asset("assets/images/cart.png"))
          : Stack(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cart.cartItems.values.toList()[index];
                    final productID = cart.cartItems.keys.toList()[index];
                    return CartWidget(
                        imageUrl: cartItem.imageUrl,
                        title: cartItem.title,
                        measure: cartItem.measure,
                        onMinus: () {
                          cart.decreaseQuantity(cartItem, index);
                        },
                        onPlus: () {
                          cart.increaseQuantity(cartItem, index);
                        },
                        onRemove: () {
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: const Text('Do you want to delete this product?'),
                            actions: [
                              Column(
                                children: [
                                  AppButton(
                                      height: 50,
                                      verPaddding: 0,
                                      name: "Yes",
                                      onTap: () {
                                        cart.removeItem(productID);
                                        Navigator.pop(context);
                                      }),
                                  AppButton(
                                      height: 50,
                                      verPaddding: 0,
                                      color: Colors.white,
                                      name: 'Back',
                                      onTap: () {
                                        Navigator.pop(context);
                                      }),
                                ],
                              )
                            ],
                          ));
                        },
                        quantity: cartItem.quantity,
                        price: cartItem.price);
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 5,
                ),
              ],
            ),
      bottomNavigationBar: cart.totalAmount <= 0
          ? AppButton(
              name: "+ Add some products",
              onTap: () {
                Navigator.pushReplacementNamed(context, "/");
              })
          : CartButton(cart: cart),
    );
  }
}
