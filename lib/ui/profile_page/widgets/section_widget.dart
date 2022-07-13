import 'package:flutter/material.dart';

import '../../widgets/app_icon.dart';

class SectionWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  const SectionWidget({
    Key? key, required this.icon, required this.title, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListTile(
            onTap: onTap,
            enableFeedback: false,
            leading: AppIcon(assetIcon: icon),
            title: Text(title, style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),),
            // trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
        const Divider(color: Colors.grey, thickness: 1,)
      ],
    );
  }
}