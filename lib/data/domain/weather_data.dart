// ignore_for_file: non_constant_identifier_names

class WeatherData {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utc_offset_seconds;
  final String timezone;
  final String timezone_abbreviation;
  final double elevation;
  final Map<String, String> hourly_units;
  final HourlyData hourly;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utc_offset_seconds,
    required this.timezone,
    required this.timezone_abbreviation,
    required this.elevation,
    required this.hourly_units,
    required this.hourly,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      generationTimeMs: (json['generationtime_ms'] as num).toDouble(),
      utc_offset_seconds: json['utc_offset_seconds'] as int,
      timezone: json['timezone'] as String,
      timezone_abbreviation: json['timezone_abbreviation'] as String,
      elevation: (json['elevation'] as num).toDouble(),
      hourly_units: Map<String, String>.from(json['hourly_units']),
      hourly: HourlyData.fromJson(json['hourly']),
    );
  }
}

class HourlyData {
  final List<String>? time;
  final List<num>? temperature_2m;
  final List<num>? apparent_temperature;
  final List<num>? relative_humidity_2m;
  final List<num>? rain;
  final List<num>? cloud_cover;

  HourlyData({
    this.time,
    this.temperature_2m,
    this.apparent_temperature,
    this.relative_humidity_2m,
    this.rain,
    this.cloud_cover,
  });

  factory HourlyData.fromJson(Map<String, dynamic> json) {
    List<num>? _numList(String key) =>
        json[key] != null ? List<num>.from(json[key]) : null;

    return HourlyData(
      time: json['time'] != null ? List<String>.from(json['time']) : null,
      temperature_2m: _numList('temperature_2m'),
      apparent_temperature: _numList('apparent_temperature'),
      relative_humidity_2m: _numList('relative_humidity_2m'),
      rain: _numList('rain'),
      cloud_cover: _numList('cloud_cover'),
    );
  }
}
