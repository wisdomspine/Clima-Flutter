import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final WeatherModel weatherModel = WeatherModel();
  void getLocationData() {
    weatherModel.getLocationWeather().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LocationScreen(
            weatherData: value,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }
}

// conditionID = decoded["weather"][0]["id"];
// temperature = decoded["main"]["temp"];
// city = decoded["name"];
