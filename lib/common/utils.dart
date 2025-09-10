import 'dart:math';

final _rand = Random();

bool randomBool() {
  return _rand.nextBool();
}

Map<String, double> randomLatLon() {
  double lat = -90 + _rand.nextDouble() * 180;   // -90 to 90
  double lon = -180 + _rand.nextDouble() * 360;  // -180 to 180
  return {'lat': lat, 'lon': lon};
}