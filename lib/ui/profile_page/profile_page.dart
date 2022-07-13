import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_colors.dart';
import 'package:grocery_store/providers/auth_provider.dart';
import 'package:grocery_store/ui/profile_page/widgets/section_widget.dart';
import 'package:grocery_store/ui/widgets/app_icon.dart';
import 'package:provider/provider.dart';

import '../orders_page/orders_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Your Details')),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Divider(color: Colors.grey, thickness: 1,),
          SectionWidget(icon: 'details', title: 'My Details', onTap: (){}),
          SectionWidget(icon: 'orders', title: 'Orders', onTap: (){
            Navigator.pushNamed(context, OrdersPage.routeName);
          }),
          SectionWidget(icon: 'help', title: 'Help', onTap: (){}),
          SectionWidget(icon: 'about', title: 'About', onTap: (){}),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Provider.of<AuthProvider>(context, listen: false).logOut();
        },
        child: Container(
          alignment: Alignment.center,
          height: 60,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.mainGreen,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.exit_to_app_rounded, color: Colors.white, size: 25,),
              SizedBox(width: 20,),
              Text('Log Out', style: TextStyle(
                color: Colors.white,
              ), )
            ],
          ),
        ),
      ),
    );
  }
}
