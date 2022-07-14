import 'package:flutter/material.dart';
import 'package:grocery_store/providers/home_provider.dart';
import 'package:grocery_store/ui/widgets/product_item.dart';
import 'package:grocery_store/ui/widgets/product_item_shimmer.dart';
import 'package:grocery_store/ui/widgets/section_item.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';

class ExclusiveItems extends StatelessWidget {
  const ExclusiveItems({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final products = home.exclusiveProducts;
    return SectionItem(
        sectionName: "Exclusive Offers",
        productsList: products,
        child: SizedBox(
          height: 230,
          child: home.isLoading
              ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return const ProductShimmer();
              })
              : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ProductItem(
                  product: product,
                  imageUrl: product.imageUrl,
                  title: product.title,
                  measure: product.measure,
                  price: product.price,
                  productId: product.productID,
                );
              }),
        ));
  }
}
