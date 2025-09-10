import 'dart:convert';

import 'package:flutter_api_test_app/data/domain/weather_data.dart';
import 'package:flutter_api_test_app/data/domain/weather_req_param.dart';
import 'package:http/http.dart' as http;

class DataService {

  static const String apiUrl = "api.open-meteo.com";
  static const String target = "v1/forecast";
  static Future<http.Response>? get(List<WeatherReqParam> params) {
    try {
      String lat = params.firstWhere((WeatherReqParam p) => p.parameterName == "latitude").value.toString();
      String lon = params.firstWhere((WeatherReqParam p) => p.parameterName == "longitude").value.toString();
      params = params.where((WeatherReqParam p) => !p.isRequired && p.isSelected).toList();
      String hourly = "";
      for (WeatherReqParam reqParam in params) {
        hourly += "${reqParam.parameterName},";
      }
      Map<String, String> queryParameters = {
        "latitude": lat,
        "longitude": lon,
        "hourly": hourly
      };
      return http.get(
        Uri.https(
          Uri.parse(apiUrl).toString(), 
          Uri.parse(target).toString(), 
          queryParameters)
        );
    } catch(e) {
      print(e);
      return null;
    }
  }
  static WeatherData? convert(String responseBody) {
    try {
      return WeatherData.fromJson(jsonDecode(responseBody));
    } catch(e) {
      print(e);
      return null;
    }
  }
}