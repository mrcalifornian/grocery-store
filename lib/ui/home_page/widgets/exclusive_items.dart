import 'package:flutter/material.dart';
import 'package:grocery_store/providers/home_provider.dart';
import 'package:grocery_store/ui/widgets/product_item.dart';
import 'package:grocery_store/ui/widgets/product_item_shimmer.dart';
import 'package:grocery_store/ui/widgets/section_item.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';

class ExclusiveItems extends StatefulWidget {
  const ExclusiveItems({
    Key? key,
  }) : super(key: key);

  @override
  State<ExclusiveItems> createState() => _ExclusiveItemsState();
}

class _ExclusiveItemsState extends State<ExclusiveItems> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<HomeProvider>(context, listen: false)
            .fetchExclusiveProducts(),
        builder: (context, snapshot) {
          return Consumer<HomeProvider>(builder: (context, data, _) {
            final products = data.exclusiveProducts;
            return SectionItem(
                sectionName: "Exclusive Offers",
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
                        return ProductShimmer();
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
