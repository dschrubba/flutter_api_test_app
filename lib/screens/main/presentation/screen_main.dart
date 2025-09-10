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
  void randomize() {
    setState(() {
      final Map<String,double> latlon = randomLatLon();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "latitude").value = latlon["lat"];
      params.firstWhere((WeatherReqParam p) => p.parameterName == "longitude").value = latlon["lon"];
      params.firstWhere((WeatherReqParam p) => p.parameterName == "temperature_2m").isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "relative_humidity_2m").isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "rain").isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "cloud_cover").isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "dew_point_2m").isSelected = randomBool();
      params.firstWhere((WeatherReqParam p) => p.parameterName == "apparent_temperature").isSelected = randomBool();
    });
  }
  void onGetData(BuildContext context) {

    DataService.get(params)?.then((Response res) {

      WeatherData? data = DataService.convert(res.body);

      print(res.body);
      print(res.request!.url);
    });

    List<WeatherReqParam> selectedParams = [...params.where((WeatherReqParam p) => !p.isRequired && p.isSelected)];
    if (selectedParams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(screenMainSnackBar(widget.flavor));
    }
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
                childAspectRatio: 1/1,
                children: params
                    .where((WeatherReqParam p) => !p.isRequired)
                    .map((WeatherReqParam p) => AppParamCheckCard(
                        weatherParam: p, 
                        flavor: widget.flavor,
                      ))
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
                        onPressed: () => saveParams(),
                        icon: Icon(LucideIcons.save300),
                        label: Text("Save"),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: FilledButton.icon(
                        onPressed: () {
                          loadParams().then((List<WeatherReqParam> list) {
                            setState(() {
                              for (final WeatherReqParam newParam in list) {
                                WeatherReqParam oldParam = params.firstWhere((WeatherReqParam p) => newParam.parameterName == p.parameterName);
                                oldParam.isSelected = newParam.isSelected;
                                oldParam.value = newParam.value;
                              }
                            });
                          });
                        },
                        icon: Icon(LucideIcons.archiveRestore300),
                        label: Text("Restore"),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: FilledButton.icon(
                        onPressed: () => randomize(),
                        icon: Icon(LucideIcons.dices300),
                        label: Text("Random"),
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed: () => onGetData(context),
                icon: Icon(LucideIcons.earth300),
                label: Text("Get Data"),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16
                ),
                child: AspectRatio(
                  aspectRatio: 2/1,
                  child: ScreenMainDataDisplay(flavor: widget.flavor,)
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
