import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class ScreenMainSparkline extends StatelessWidget {
  final Color lineColor;
  final List<dynamic>? data;
  final Flavor flavor;
  const ScreenMainSparkline({super.key, this.data, required this.lineColor, required this.flavor});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: (data == null) ? 0 : 1,
      duration: Duration(milliseconds: 250),
      child:  
      (data != null)
       ? Sparkline(
          lineColor: lineColor,
          data: data!.map((e) => double.parse(e.toString())).toList(),
        )
        : Container()
    );
  }
}