import 'package:flutter_api_test_app/common/widgets/app_param_input.dart';
import 'package:flutter_api_test_app/common/widgets/section_title.dart';
import 'package:flutter_api_test_app/data/domain/weather_req_param.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

class ScreenMain extends StatelessWidget {
  final Flavor flavor;
  static const int crossAxisCount = 1;

  const ScreenMain({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    List<WeatherReqParam> params = [
      WeatherReqParam<double>("Latitude", "latitude", "°", 0, true),
      WeatherReqParam<double>("Longitude", "longitude", "°", 0, true),
      //WeatherReqParam<double>("Temperature", "temperature_2m", "°C", 0, true),
      //WeatherReqParam<double>("Humidity (rel)", "relative_humidity_2m", "%", 0, false),
      //WeatherReqParam<double>("Rain", "rain", "mm", 0, false),
    ];

    return Column(
      children: [
        SectionTitle(
          flavor: flavor,
          title: "API",
          iconData: LucideIcons.sun300,
        ),
        Column(
          children: [
            for (int i = 0; i < params.length; i++)
              AppParamInput(flavor: flavor, weatherParam: params[i]),
            FilledButton.icon(onPressed: () => {}, icon: Icon(LucideIcons.earth300), label: Text("Get Data"))
          ],
        ),
      ],
    );
  }
}
