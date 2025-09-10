import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

class ScreenMainDataDisplay extends StatefulWidget {
  final Flavor flavor;
  const ScreenMainDataDisplay({super.key, required this.flavor});

  @override
  State<ScreenMainDataDisplay> createState() => _ScreenMainDataDisplayState();
}

class _ScreenMainDataDisplayState extends State<ScreenMainDataDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.flavor.crust,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(child: Text("data"),),
    );
  }
}