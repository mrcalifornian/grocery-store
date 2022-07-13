import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../app_constants/app_colors.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white60,
        highlightColor: AppColors.transparentGreen,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 10,
          ),
          height: 210,
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: Colors.grey, width: 1),
            color: Colors.white
          ),
          // child: CircularProgressIndicator(),
        ));
  }
}
