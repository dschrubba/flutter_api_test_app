import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {

  final IconData? iconData;
  final String title;
  final Flavor flavor;

  const SectionTitle({super.key, required this.flavor, required this.title, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: flavor.base,
      padding: EdgeInsets.all(16),
      child: Row(
        spacing: iconData != null ? 16 : 0,
        children: [
          if (iconData != null)
          Icon(
            iconData,
            color: flavor.text,
            size: 24,
          ),
          Text(title, style: TextStyle(
            color: flavor.text,
            fontSize: 20
          ),)
        ],
      ),
    );
  }
}