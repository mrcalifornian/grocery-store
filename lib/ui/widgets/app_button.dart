import 'package:flutter/material.dart';

import '../../app_constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  double height;
  double verPaddding;
  double horPadding;
  Color color;

  AppButton({
    Key? key,
    required this.name,
    required this.onTap,
    this.height = 90,
    this.verPaddding =15,
    this.horPadding =20,
    this.color = AppColors.mainGreen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding:  EdgeInsets.symmetric(
        horizontal: horPadding,
        vertical: verPaddding,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Text(
            name,
            style: TextStyle(
              color: color == Colors.white? Colors.black : Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
