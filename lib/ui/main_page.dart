import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_colors.dart';
import 'package:grocery_store/providers/category_provider.dart';
import 'package:grocery_store/ui/cart_page/cart_page.dart';
import 'package:grocery_store/ui/explore_page/explore_page.dart';
import 'package:grocery_store/ui/favourites_page/favourites_page.dart';
import 'package:grocery_store/ui/home_page/home_page.dart';
import 'package:grocery_store/ui/profile_page/profile_page.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';
import 'no_internet.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<HomeProvider>(context, listen: false).getLocation();
      await Provider.of<HomeProvider>(context, listen: false).getHomeProducts();
      await Provider.of<CategoryProvider>(context, listen: false).getCategories();
    }).catchError((e) {
      Future.delayed(const Duration(seconds: 5)).then((value) =>
          Navigator.pushReplacementNamed(context, NoInternet.routeName));
    });
    super.initState();
  }

  int currentPage = 0;

  List pages = const [
    HomePage(),
    ExplorePage(),
    CartPage(),
    FavouritesPage(),
    ProfilePage(),
  ];

  void _setPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          elevation: 0,
          enableFeedback: false,
          backgroundColor: Colors.white,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPage,
          onTap: _setPage,
          selectedItemColor: AppColors.mainGreen,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.store_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              // activeIcon: AppIcon(assetIcon: "categories_active"),
              // icon: AppIcon(assetIcon: "categories"),
              icon: Icon(
                Icons.ballot_outlined,
              ),
              //Icons.auto_awesome_mosaic_outlined),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: "Favourites",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "Account",
            ),
          ]),
    );
  }
}
