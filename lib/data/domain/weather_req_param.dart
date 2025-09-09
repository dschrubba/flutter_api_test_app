import 'package:flutter/widgets.dart';

class WeatherReqParam<T> {
  final String title;
  final String parameterName;
  final String displayUnit;
  final bool isRequired;
  final IconData? iconData;
  T? _value;
  set value(T? v) {
    if ((v != null) && (_value == null)) {
      _value = v;
    }
  }

  T? get value => _value;
  WeatherReqParam(
    this.title,
    this.parameterName,
    this.displayUnit, 
    this._value,
    this.isRequired,
    [this.iconData]
    );

  bool setValueOnce(T v) {
    if (_value == null) {
      _value = v;
      return true;
    }
    return false;
  }
  Type getType() {
    return T;
  }

  String valuesAsString() => _value.toString();
}
