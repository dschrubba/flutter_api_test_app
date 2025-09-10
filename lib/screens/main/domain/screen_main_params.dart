import 'dart:developer';

import 'package:flutter_api_test_app/data/domain/weather_req_param.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<WeatherReqParam> params = [
  WeatherReqParam<double>("Latitude", "latitude", "°", 0, true, false),
  WeatherReqParam<double>("Longitude", "longitude", "°", 0, true, false),
  WeatherReqParam<double>("Temperature", "temperature_2m", "°C", 0, false, false),
  WeatherReqParam<double>("Rel. Humidity (2m)", "relative_humidity_2m", "%", 0, false, false),
  WeatherReqParam<double>("Rain", "rain", "mm", 0, false, false),
  WeatherReqParam<double>("Cloud Cover", "cloud_cover", "%", 0, false, false),
  WeatherReqParam<double>("Dew Point (2m)", "dew_point_2m", "°C", 0, false, false),
  WeatherReqParam<double>("Apparent Temperature", "apparent_temperature", "°C", 0, false, false),
];

Future<bool> saveParams() async {
try {
  SharedPreferences instance = await SharedPreferences.getInstance();
  await instance.setStringList(
  "params",
  params.map((p) => p.toJson()).toList(),
);
  return true;
}
 catch (e) {
  log(e.toString());
  return false;
 }
}

Future<List<WeatherReqParam>> loadParams() async {
  try {
    SharedPreferences instance = await SharedPreferences.getInstance();
    List<String>? list = instance.getStringList("params");
    if (list == null) return [];

    return list.map((s) => WeatherReqParam.fromJson(s)).toList();
  } catch (e) {
    log(e.toString());
    return [];
  }
}