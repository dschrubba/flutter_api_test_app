import 'dart:developer';

import 'package:flutter_api_test_app/common/utils.dart';
import 'package:flutter_api_test_app/common/widgets/app_param_check_card.dart';
import 'package:flutter_api_test_app/common/widgets/app_param_input.dart';
import 'package:flutter_api_test_app/common/widgets/section_title.dart';
import 'package:flutter_api_test_app/data/domain/data_service.dart';
import 'package:flutter_api_test_app/data/domain/weather_data.dart';
import 'package:flutter_api_test_app/data/domain/weather_req_param.dart';
import 'package:flutter_api_test_app/screens/main/domain/screen_main_params.dart';
import 'package:flutter_api_test_app/screens/main/domain/screen_main_snackbar.dart';
import 'package:flutter_api_test_app/screens/main/widgets/screen_main_data_display.dart';
import 'package:http/http.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

class ScreenMain extends StatefulWidget {
  final Flavor flavor;
  static const int crossAxisCount = 1;
  const ScreenMain({super.key, required this.flavor});
  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  WeatherData? currentData;
  void randomize() {
    setState(() {
      final Map<String, double> latlon = randomLatLon();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "latitude").value = latlon["lat"];
      params.firstWhere((WeatherReqParam p) => p.parameterName == "longitude").value = latlon["lon"];
      params.firstWhere((WeatherReqParam p) => p.parameterName == "temperature_2m",).isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "relative_humidity_2m",).isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "rain").isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "cloud_cover",).isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "dew_point_2m",).isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "apparent_temperature",).isSelected = randomBool(); 
      saveParams();
      getData(context);
    });
  }

  Future<void> getData(BuildContext context) async {
    List<WeatherReqParam> selectedParams = [
      ...params.where((WeatherReqParam p) => !p.isRequired && p.isSelected),
    ];
    if (selectedParams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        screenMainSnackBar(
          widget.flavor,
          'Please select at least one parameter',
        ),
      );
    } else {
      await DataService.get(params)?.then((Response res) {
        setState(() {
          currentData = DataService.convert(res.body);
          if (currentData != null) {
            DataService.saveToSharedPrefs(currentData!);
          }
        });
      });
    }
  }

  WeatherData? initialData;

  @override
  void initState() {
    // Try loading data from shared prefs
    if (initialData == null) {
      DataService.loadFromSharedPrefs().then((d) {
        log(d.toString());
        if (d != null) {
          // Set data, if current data is null
          initialData = d;
          if (initialData != null && currentData == null) {
            setState(() {
              currentData = initialData;
            });
          }
        }
      });
    }

    // Try loading params from shared prefs
    loadParams().then((List<WeatherReqParam> p)  {
      if (p.isNotEmpty) {
        setState(() {
          params = p;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          flavor: widget.flavor,
          title: "API",
          iconData: LucideIcons.sun300,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              for (int i = 0; i < params.length; i++)
                if (params[i].isRequired)
                  AppParamInput(flavor: widget.flavor, weatherParam: params[i]),
              GridView.count(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                children: params
                    .where((WeatherReqParam p) => !p.isRequired)
                    .map(
                      (WeatherReqParam p) => AppParamCheckCard(
                        weatherParam: p,
                        flavor: widget.flavor,
                      ),
                    )
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  spacing: 8,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: FilledButton.icon(
                        onPressed: () => randomize(),
                        icon: Icon(LucideIcons.dices300),
                        label: Text("Random"),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: FilledButton.icon(
                        onPressed: () => getData(context),
                        icon: Icon(LucideIcons.earth300),
                        label: Text("Get Data"),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: AspectRatio(
                  aspectRatio: 1.7 / 1,
                  child: AnimatedOpacity(
                    opacity: currentData != null ? 1 : 0,
                    duration: Duration(milliseconds: 250),
                    child: (currentData != null)
                        ? ScreenMainDataDisplay(
                            weatherData: currentData!,
                            flavor: widget.flavor,
                          )
                        : Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
