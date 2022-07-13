import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/providers/cart_provider.dart';
import 'package:grocery_store/ui/product_detail/product_detail.dart';
import 'package:provider/provider.dart';
import '../../app_constants/app_colors.dart';
import '../../models/product.dart';

class ProductItem extends StatelessWidget {
  final String productId;
  final Product product;
  final String imageUrl;
  final String title;
  final String measure;
  final double price;
  double margin;

  ProductItem({
    Key? key,
    required this.productId,
    required this.product,
    required this.imageUrl,
    required this.title,
    required this.measure,
    required this.price,
    this.margin = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 10,
      ),
      height: 210,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.mainGreen, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailScreen.routeName,
                  arguments: product);
            },
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                height: 100,
                child: CachedNetworkImage(
                    errorWidget: (context, url, error) => Image.asset('assets/images/holder.jpg'),
                    imageUrl: imageUrl
                )
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "${measure}, Price",
            style: const TextStyle(color: Colors.black54),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${price}",
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              GestureDetector(
                onTap: () {
                  cart.addItem(product);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.mainGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Provider.of<CartProvider>(context).cartBox.containsKey(product.productID)
                        ? Icons.shopping_cart_outlined
                        :Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
