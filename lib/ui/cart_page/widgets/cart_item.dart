import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app_constants/app_colors.dart';

class CartWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String measure;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback onRemove;
  final int quantity;
  final num price;
  const CartWidget({Key? key, required this.imageUrl, required this.title, required this.measure, required this.onMinus, required this.onPlus, required this.onRemove, required this.quantity, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 90,
                width: 90,
                padding: const EdgeInsets.all(10),
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => Image.asset('assets/images/holder.jpg'),
                  imageUrl: imageUrl
                )
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${measure}, Price",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: onMinus,
                        child: Icon(
                          Icons.remove,
                          color: quantity == 1? Colors.grey : AppColors.mainGreen,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.black38, width: 1)),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        height: 40,
                        width: 40,
                        child: Text("${quantity}",
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                      ),
                      GestureDetector(
                        onTap: onPlus,
                        child: const Icon(
                          Icons.add,
                          color: AppColors.mainGreen,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Container(
                alignment: Alignment.centerRight,
                height: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: onRemove,
                      child: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "\$${(price * quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
          height: 5,
        ),
      ],
    );
  }
}
