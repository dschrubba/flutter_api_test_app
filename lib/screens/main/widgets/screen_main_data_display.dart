import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test_app/data/domain/weather_data.dart';
import 'package:flutter_api_test_app/screens/main/widgets/screen_main_sparkline.dart';
class ScreenMainDataDisplay extends StatefulWidget {
  final WeatherData weatherData;
  final Flavor flavor;
  const ScreenMainDataDisplay({super.key, required this.weatherData, required this.flavor});

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
      child: Stack(
        children: [ 
          ScreenMainSparkline(data: widget.weatherData.hourly.rain, lineColor: widget.flavor.blue, flavor: widget.flavor,),
          ScreenMainSparkline(data: widget.weatherData.hourly.cloud_cover, lineColor: widget.flavor.text, flavor: widget.flavor,),
          ScreenMainSparkline(data: widget.weatherData.hourly.temperature_2m, lineColor: widget.flavor.red, flavor: widget.flavor,),
          ScreenMainSparkline(data: widget.weatherData.hourly.relative_humidity_2m, lineColor: widget.flavor.green, flavor: widget.flavor,),
          ScreenMainSparkline(data: widget.weatherData.hourly.dew_point_2m, lineColor: widget.flavor.lavender, flavor: widget.flavor,),
          ScreenMainSparkline(data: widget.weatherData.hourly.apparent_temperature, lineColor: widget.flavor.flamingo, flavor: widget.flavor,),
      ])
    );
  }
}