import 'package:geolocator/geolocator.dart';

class Location {
  Future<Position> getCurrentLocation() async {
    final Geolocator geolocator = Geolocator();
    if (!(await geolocator.isLocationServiceEnabled())) {
      return null;
    }
    return geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
