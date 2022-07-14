import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_colors.dart';

import '../orders_page/orders_page.dart';
import '../widgets/app_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  static String routeName = '/success-page';

  Future<bool> onWillPop(BuildContext context) async{
    Navigator.pushReplacementNamed(context, '/');
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/tick.png'),
            const SizedBox(height: 20,),
            const Text(
              'Your Order has been accepted',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            const SizedBox(height: 20,),
            AppButton(
                height: 60,
                verPaddding: 5,
                name: "Recent orders",
                onTap: () {
                  Navigator.pushNamed(context, OrdersPage.routeName);
                }),
            Container(
              height: 45,
              margin:  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1,),
                    color: Colors.white,
                  ),
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}
