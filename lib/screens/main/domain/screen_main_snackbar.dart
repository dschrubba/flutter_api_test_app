import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

SnackBar screenMainSnackBar(Flavor flavor) {
    return SnackBar(
      backgroundColor: flavor.crust,
      content: Flex(
        direction: Axis.horizontal,
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              'Please select at least one parameter',
              style: TextStyle(color: flavor.yellow),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: 48,
              height: 48,
              child: Image.asset(
                "assets/meow_nod.gif",
                width: 48,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }