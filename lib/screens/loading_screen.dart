import 'package:climate/screens/location_screen.dart';
import 'package:climate/services/location.dart';
import 'package:climate/services/networking.dart';
import 'package:climate/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? lati;
  double? longi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    lati = location.latitude;
    longi = location.longitude;

WeatherModel weatherModel=WeatherModel();
String decodedData=await weatherModel.getLocationWeather(lati!, longi!);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen(decodedData: decodedData,)));
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
}
