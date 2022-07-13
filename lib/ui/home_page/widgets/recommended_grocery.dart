import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_colors.dart';
import 'package:grocery_store/ui/no_internet.dart';
import 'package:grocery_store/ui/widgets/product_item.dart';
import 'package:grocery_store/ui/widgets/section_item.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../providers/home_provider.dart';
import '../../widgets/product_item_shimmer.dart';

class RecommendedGrocery extends StatelessWidget {

  const RecommendedGrocery({Key? key, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<HomeProvider>(context, listen: false)
            .fetchRecommendedGroceries(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.none){
            Navigator.pushReplacementNamed(context, NoInternet.routeName);
          }
          return Consumer<HomeProvider>(builder: (context, data, child) {
            final products = data.recommendedGroceries;
            return SectionItem(
                sectionName: "Recommended Groceries",
                productsList: products,
                child: Column(
                  children: [
                    child!,
                    SizedBox(
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
                    ),
                  ],
                ));
          },
          child: SizedBox(
            height: 90,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    height: 90,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: index.isEven
                          ? AppColors.grbackYellow
                          : AppColors.grbackGreen,
                    ),
                    child: Row(
                      children: [
                        Image.asset(index.isEven
                            ? "assets/images/spice.png"
                            : "assets/images/rice.png",
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(index.isEven ? "Pulses" : "Rice", style: TextStyle(
                          fontSize: 18,
                        ),),
                      ],
                    ),
                  );
                }),
          ),
          );
        });
  }
}
