import 'package:climate/screens/city_screen.dart';
import 'package:climate/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climate/utilities/constants.dart';
import 'package:climate/services/Location.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.decodedData});

  final dynamic decodedData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? temperature;
  int? condition;
  String? cityName;
  String? weatherIcon;
  String? weatherMessage;

  @override
  void initState() {
    super.initState();
    // Start the location update when the widget is initialized
    updateLocation();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = null;
        condition = null;
        cityName = null;
        weatherIcon = null;
        weatherMessage = null;
      } else {
        temperature = weatherData['main']['temp'];
        condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];

        WeatherModel weatherModel = WeatherModel();
        weatherIcon = weatherModel.getWeatherIcon(condition!);
        weatherMessage = weatherModel.getMessage(temperature!.toInt());
      }
    });
  }

  Future<void> updateLocation() async {
    Location location = Location();
    dynamic data = await location.getCurrentLocation();
    updateUI(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () async {
                    await updateLocation();
                  },
                  child: Icon(
                    Icons.near_me,
                    size: 50.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
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
                    temperature != null ? '$temperature°' : '',
                    style: kTempTextStyle,
                  ),
                  Text(
                    weatherIcon ?? '',
                    style: kConditionTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                '$weatherMessage $cityName',
                textAlign: TextAlign.right,
                style: kMessageTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
