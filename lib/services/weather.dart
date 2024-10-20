import 'networking.dart';

const appKey = '93b99bc577c65f041f18d15f72d2c572';

class WeatherModel {

  Future<String> getLocationWeather(double lati, double longi) async {
    Networking networking = Networking(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lati&lon=$longi&appid=$appKey&units=imperial');

    var weatherData = await networking.getData();
    String decodedData = await weatherData;
    return decodedData;
  }

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
