import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_colors.dart';
import 'package:grocery_store/models/product.dart';
import 'package:grocery_store/providers/favourites_provider.dart';
import 'package:grocery_store/ui/product_detail/widgets/expandable_list_tile.dart';
import 'package:grocery_store/ui/widgets/app_button.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../widgets/cart_icon.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    Key? key,
  }) : super(key: key);

  static String routeName = "/product-detail-screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 350,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      product.title,
                      style:
                          const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${product.measure}, Price",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: GestureDetector(
                        onTap: () async {
                          await Provider.of<FavouritesProvider>(context,
                                  listen: false)
                              .addProduct(product);
                        },
                        child: Icon(
                          Provider.of<FavouritesProvider>(context)
                                  .favBox
                                  .containsKey(product.productID)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: AppColors.mainGreen,
                          size: 30,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ExpandableWidget(
                  description: product.description,
                  sectionTitle: "Product Detail",
                  trailing: Container(),
                ),
                ExpandableWidget(
                  sectionTitle: "Nutrition",
                  description: product.nutritons,
                  trailing: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.searchBarColor,
                    ),
                    child: const Text("100g"),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 350,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: AppColors.searchBarColor,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 15,
            ),
            child: CachedNetworkImage(imageUrl: product.imageUrl),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 10,
              ),
              child: Row(
                children: [
                  InkWell(
                    enableFeedback: true,
                    radius: 5,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                  const Spacer(),
                  const CartIcon(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
      Provider.of<CartProvider>(context).cartBox.containsKey(product.productID)
          ? AppButton(name: 'Already in cart', onTap: (){},)
          :AppButton(
        name: "Add to Cart",
        onTap: () {
          cart.addItem(product);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.title} added to the cart!'),
              backgroundColor: AppColors.mainGreen,
            ),
          );
        },
      ),
    );
  }
}
