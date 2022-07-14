import 'package:flutter/material.dart';
import 'package:grocery_store/providers/home_provider.dart';
import 'package:grocery_store/ui/home_page/widgets/banner_item.dart';
import 'package:grocery_store/ui/home_page/widgets/bestselling_items.dart';
import 'package:grocery_store/ui/home_page/widgets/exclusive_items.dart';
import 'package:grocery_store/ui/home_page/widgets/recommended_grocery.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, size: 18,),
            Text(
              home.isLoadingLocation ? "Loading..." : home.address,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: const [
                  BannerItem(),
                  ExclusiveItems(),
                  BestSellingItems(),
                  RecommendedGrocery(),
                ],
              ),
            ),
    );
  }
}
