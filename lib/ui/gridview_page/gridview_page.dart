import 'package:flutter/material.dart';
import 'package:grocery_store/models/gridpage_model.dart';
import 'package:grocery_store/models/product.dart';
import 'package:grocery_store/ui/widgets/cart_icon.dart';
import 'package:grocery_store/ui/widgets/product_item.dart';

class GridviewPage extends StatelessWidget {
  static String routeName = "/gridview-page";

  const GridviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = ModalRoute.of(context)?.settings.arguments as GridPageModel;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Center(
          child: Text(
            items.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          CartIcon(),
        ],
      ),
      body: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: items.products.length,
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            mainAxisExtent: 210,
          ),
          itemBuilder: (context, index) {
            final Product product = items.products[index];
            return ProductItem(
              product: product,
              imageUrl: product.imageUrl,
              title: product.title,
              measure: product.measure,
              price: product.price,
              margin: 0,
              productId: product.productID,
            );
          }),
    );
  }
}
