import 'package:clima/glitches/Glitch.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final dynamic weatherData;

  LocationScreen({this.weatherData});
  @override
  _LocationScreenState createState() =>
      _LocationScreenState(weatherModel: WeatherModel());
}

class _LocationScreenState extends State<LocationScreen> {
  String weatherIcon = "";
  int temperature = 0;
  final WeatherModel weatherModel;
  String city = "empty";
  String weatherText = "Unable to get weather data";
  dynamic _weatherData;

  _LocationScreenState({this.weatherModel});

  @override
  void initState() {
    super.initState();
    updateUi(widget.weatherData);
  }

  void updateUi(dynamic weatherData) {
    _weatherData = weatherData;
    weatherIcon = weatherModel.getWeatherIcon(_weatherData["weather"][0]["id"]);
    temperature = num.parse("${_weatherData["main"]["temp"]}").toInt();
    city = _weatherData["name"];
    weatherText = weatherModel.getMessage(temperature);
    setState(() {});
  }

  void _showDialog(BuildContext context, Glitch glitch) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          glitch?.description,
          textAlign: TextAlign.center,
        ),
        title: Text(
          glitch?.title,
          textAlign: TextAlign.center,
        ),
        actions: [
          OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          RaisedButton(
            child: Text("Got it"),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      weatherModel.getLocationWeather().then((value) {
                        value.fold((l) => _showDialog(context, l), (r) {
                          updateUi(value);
                        });
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CityScreen(),
                        ),
                      ).then((newCity) {
                        newCity != null
                            ? weatherModel
                                .getCityWeather(newCity)
                                .then((value) {
                                value.fold(
                                  (l) => _showDialog(context, l),
                                  (r) => updateUi(r),
                                );
                              })
                            : null;
                      });
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherText in $city",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
