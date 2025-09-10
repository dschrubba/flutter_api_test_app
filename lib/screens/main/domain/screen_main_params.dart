import 'dart:developer';

import 'package:flutter_api_test_app/data/domain/weather_req_param.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<WeatherReqParam> params = [
  WeatherReqParam("Latitude", "latitude", "°", 0, true, false),
  WeatherReqParam("Longitude", "longitude", "°", 0, true, false),
  WeatherReqParam("Temperature", "temperature_2m", "°C", 0, false, false),
  WeatherReqParam("Rel. Humidity (2m)", "relative_humidity_2m", "%", 0, false, false),
  WeatherReqParam("Rain", "rain", "mm", 0, false, false),
  WeatherReqParam("Cloud Cover", "cloud_cover", "%", 0, false, false),
  WeatherReqParam("Dew Point (2m)", "dew_point_2m", "°C", 0, false, false),
  WeatherReqParam("Apparent Temperature", "apparent_temperature", "°C", 0, false, false),
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