import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_constants/app_colors.dart';
import '../../providers/cart_provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      enableFeedback: false,
        onPressed: (){
      // Navigator.pushNamed(context, CartPage.routeName);
    }, icon: Stack(
      children: [
        const Icon(Icons.shopping_cart_outlined, size: 25,),
        Positioned(
          top: -1,
          right: -1,
          child: Container(
            // margin: EdgeInsets.all(5),
            alignment: Alignment.topCenter,
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.mainGreen,
            ),
            child: Text('${Provider.of<CartProvider>(context).cartItems.length}', style: const TextStyle(
              color: Colors.white,
            ),),
          ),
        )
      ],
    ));
  }
}
