import 'package:clima/glitches/Glitch.dart';
import 'package:clima/glitches/LocationOffGlitch.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  Future<Either<Glitch, Position>> getCurrentLocation() async {
    final Geolocator geolocator = Geolocator();
    if (!(await geolocator.isLocationServiceEnabled())) {
      return Left(LocationOffGlitch());
    }
    return Right(await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ));
  }
}
