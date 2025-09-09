import 'package:flutter_api_test_app/data/domain/weather_base.dart';

class WeatherHourly extends Weather {

  WeatherHourly({
    required double latitude,
    required double longitude,
    required double generationTimeMs,
    required int utcOffsetSeconds,
    required String timezone,
    required String timezoneAbbreviation,
    required double elevation,
  }) : super(
          latitude: latitude,
          longitude: longitude,
          generationTimeMs: generationTimeMs,
          utcOffsetSeconds: utcOffsetSeconds,
          timezone: timezone,
          timezoneAbbreviation: timezoneAbbreviation,
          elevation: elevation,
        );

}