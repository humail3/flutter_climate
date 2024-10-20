import 'package:climate/services/weather.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<dynamic> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;

      WeatherModel weatherModel = WeatherModel();
      String decodedData =
          await weatherModel.getLocationWeather(latitude!, longitude!);

      return decodedData;
    } catch (e) {
      print(e);
    }
  }
}
