import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_colors.dart';
import 'package:grocery_store/ui/cart_page/cart_page.dart';
import 'package:grocery_store/ui/explore_page/explore_page.dart';
import 'package:grocery_store/ui/favourites_page/favourites_page.dart';
import 'package:grocery_store/ui/home_page/home_page.dart';
import 'package:grocery_store/ui/profile_page/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List pages = const [
      HomePage(),
      ExplorePage(),
      CartPage(),
      FavouritesPage(),
      ProfilePage(),
    ];

    void _setPage(int index) {
      setState(() {
        _currentPage = index;
      });
    }

    return Scaffold(
      body: pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
          elevation: 0,
          enableFeedback: false,
          backgroundColor: Colors.white,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentPage,
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
              icon: Icon(Icons.ballot_outlined,), //Icons.auto_awesome_mosaic_outlined),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined,),
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
