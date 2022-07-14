import 'package:flutter/material.dart';
import 'package:grocery_store/ui/widgets/app_button.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  static String routeName = '/no-internet';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        alignment: Alignment.center,
        child: const Text('No Internet Connection'),
      ),
      bottomNavigationBar: AppButton(name: "Retry", onTap: (){
        Navigator.pushReplacementNamed(context, '/');
      }),
    );
  }
}
