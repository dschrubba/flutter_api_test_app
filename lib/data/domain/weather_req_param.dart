import 'dart:convert';
import 'package:flutter/widgets.dart';

class WeatherReqParam<T> {
  final String title;
  final String parameterName;
  final String displayUnit;
  final bool isRequired;
  bool isSelected;
  final IconData? iconData;
  num? value;
  WeatherReqParam(
    this.title,
    this.parameterName,
    this.displayUnit, 
    this.value,
    this.isRequired,
    this.isSelected,
    [this.iconData]
    );

String valuesAsString() => value.toString();
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'parameterName': parameterName,
      'displayUnit': displayUnit,
      'isRequired': isRequired,
      'isSelected': isSelected,
      'value': value,
      'iconCodePoint': iconData?.codePoint ?? -1,
      'iconFontFamily': iconData?.fontFamily ?? "",
      'iconFontPackage': iconData?.fontPackage ?? "",
      'iconMatchTextDirection': iconData?.matchTextDirection ?? false,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory WeatherReqParam.fromJson(String jsonStr) {
    final map = jsonDecode(jsonStr) as Map<String, dynamic>;
    IconData? icon;
    if ((map['iconCodePoint'] != null) && (map['iconCodePoint'] >= 0)) {
      icon = IconData(
        map['iconCodePoint'],
        fontFamily: map['iconFontFamily'],
        fontPackage: map['iconFontPackage'],
        matchTextDirection: map['iconMatchTextDirection'] ?? false,
      );
    }
    return WeatherReqParam(
      map['title'] as String,
      map['parameterName'] as String,
      map['displayUnit'] as String,
      (map['value'] as num?)?.toDouble(),
      map['isRequired'] as bool,
      map['isSelected'] as bool,
      icon,
    );
  }
}
