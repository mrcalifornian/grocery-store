import 'package:flutter/material.dart';
import 'package:grocery_store/ui/widgets/product_item.dart';
import 'package:grocery_store/ui/widgets/section_item.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../providers/home_provider.dart';
import '../../widgets/product_item_shimmer.dart';

class BestSellingItems extends StatelessWidget {
  const BestSellingItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<HomeProvider>(context, listen: false)
            .fetchBestSellingProducts(),
        builder: (context, snapshot) {
          return Consumer<HomeProvider>(builder: (context, data, _) {
            final products = data.bestSellingProducts;
            return SectionItem(
                sectionName: "Best Selling",
                productsList: products,
                child: SizedBox(
                  height: 230,
                  child: snapshot.connectionState == ConnectionState.waiting
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
          });
        });
  }
}
