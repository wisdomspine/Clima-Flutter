import 'package:clima/glitches/Glitch.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

const String API_KEY = "766675a6d2b292e3a3788a5f3ad49cf8";
const String BASE_URL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  Future<Either<Glitch, dynamic>> getLocationWeather() async {
    Either<Glitch, dynamic> position = await Location().getCurrentLocation();
    return position.fold((l) => Left(l), (r) async {
      return NetworkHelper(
        "$BASE_URL?lat=${r.latitude}&lon=${r.longitude}&appid=$API_KEY&units=metric",
      ).getData();
    });
  }

  Future<Either<Glitch, dynamic>> getCityWeather(String city) async {
    return NetworkHelper(
      "$BASE_URL?q=$city&appid=$API_KEY&units=metric",
    ).getData();
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
