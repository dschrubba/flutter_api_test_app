// ignore_for_file: non_constant_identifier_names

class WeatherData {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final Map<String, String> hourly_units;
  final HourlyData hourly;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.hourly_units,
    required this.hourly,
  });
}

class HourlyData {
  final List<String> time;
  final List<double> temperature_2m;
  final List<double> apparent_temperature;
  final List<int> relative_humidity_2m;
  final List<double> rain;
  final List<int> cloud_cover;

  HourlyData({
    required this.time,
    required this.temperature_2m,
    required this.apparent_temperature,
    required this.relative_humidity_2m,
    required this.rain,
    required this.cloud_cover,
  });
}