import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_constants.dart';
import 'package:grocery_store/models/cart_item_model.dart';
import 'package:grocery_store/models/product.dart';
import 'package:grocery_store/providers/auth_provider.dart';
import 'package:grocery_store/providers/cart_provider.dart';
import 'package:grocery_store/providers/category_provider.dart';
import 'package:grocery_store/providers/favourites_provider.dart';
import 'package:grocery_store/providers/home_provider.dart';
import 'package:grocery_store/providers/orders_provider.dart';
import 'package:grocery_store/ui/auth_page/auth_screen.dart';
import 'package:grocery_store/ui/cart_page/cart_page.dart';
import 'package:grocery_store/ui/cart_page/success_page.dart';
import 'package:grocery_store/ui/gridview_page/gridview_page.dart';
import 'package:grocery_store/ui/main_page.dart';
import 'package:grocery_store/ui/no_internet.dart';
import 'package:grocery_store/ui/orders_page/orders_page.dart';
import 'package:grocery_store/ui/product_detail/product_detail.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>(AppConstants.favBox);
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>(AppConstants.cartBox);
  await Hive.openBox<String>(AppConstants.authBox);
  runApp(const GroceryStore());
}

class GroceryStore extends StatelessWidget {
  const GroceryStore({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouritesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grocery Store',
            theme: ThemeData(
              // fontFamily: "Abel",
              accentColor: Colors.black,
              primaryColor: Colors.white,
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 1,
                foregroundColor: Colors.black,
              ),
              textTheme: const TextTheme(
                titleMedium: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            home: auth.isAuth
                ? const MainPage()
                : const AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (context) => const ProductDetailScreen(),
              GridviewPage.routeName: (context) => const GridviewPage(),
              OrdersPage.routeName: (context) => const OrdersPage(),
              CartPage.routeName: (context) => const CartPage(),
              NoInternet.routeName: (context) => const NoInternet(),
              SuccessPage.routeName: (context) => const SuccessPage()
            },
          );
        },
      ),
    );
  }
}
