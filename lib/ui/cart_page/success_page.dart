import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            SizedBox(height: 20,),
            Text(
              'Your Order has been accepted',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
            SizedBox(height: 20,),
            AppButton(
                height: 60,
                verPaddding: 5,
                name: "Recent orders",
                onTap: () {
                  Navigator.pushNamed(context, OrdersPage.routeName);
                }),
            AppButton(
                height: 60,
                color: Colors.white,
                name: 'Home',
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                }),
          ],
        ),
      ),
    ),
    );
  }
}
