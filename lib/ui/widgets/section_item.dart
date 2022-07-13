import 'package:flutter/material.dart';
import 'package:grocery_store/app_constants/app_colors.dart';
import 'package:grocery_store/models/gridpage_model.dart';
import 'package:grocery_store/models/product.dart';
import 'package:grocery_store/ui/gridview_page/gridview_page.dart';

class SectionItem extends StatelessWidget {
  final String sectionName;
  final List productsList;
  final Widget child;

  const SectionItem({
    Key? key,
    required this.sectionName,
    required this.child,
    required this.productsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, GridviewPage.routeName, arguments: GridPageModel(title: sectionName, products: productsList));
                },
                child: Text("See all", style: TextStyle(
                  color: AppColors.mainGreen,
                  fontSize: 15,
                ),),
              ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
