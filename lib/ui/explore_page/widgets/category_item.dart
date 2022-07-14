import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Color borderColor;
  final Color backgroundColor;
  const CategoryItem({Key? key, required this.imageUrl, required this.title, required this.borderColor, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
        ),
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Image.network(imageUrl, height: 100,),
          const Spacer(),
          Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17
            ),),
        ],
      ),
    );
  }
}
