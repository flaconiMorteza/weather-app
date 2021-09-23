// ignore: avoid_relative_lib_imports
import '../lib/src/models/weather_data.dart';

// ignore: avoid_relative_lib_imports
import '../lib/src/models/city_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String strCityjson = "";
  String strWeatherJson = "";

  setUp(() {
    strCityjson = "{\"title\":\"Berlin\",\"woeid\":638242}";
    strWeatherJson = '''
    {
      "weather_state_name":"Heavy Cloud",
      "applicable_date":"2021-09-23",
      "min_temp":12.0,
      "max_temp":21.675,
      "the_temp":20.34,
      "wind_speed":6.719674059243352,
      "air_pressure":1020.5,
      "humidity":70
  }
  ''';
  });

  group('Model Testing', () {
    test('Testing City model toJson', () {
      City _city = City(title: 'Berlin', woeid: 638242);

      expect(_city.toJson(), strCityjson);
    });

    test('Testing City model fromJson', () {
      City _city1 = City(title: 'Berlin', woeid: 638242);
      City _city2 = City.fromJson(strCityjson);

      expect(_city1, _city2);
    });

    test('Testing weather model from and to Json', () {
      WeatherData _weatherData = WeatherData.fromJson(strWeatherJson);
      expect(_weatherData.air_pressure, 1020.5);
      expect(_weatherData.the_temp, 20.34);
      WeatherData _weatherData2 = _weatherData.copyWith(max_temp: 21.675);
      expect(_weatherData, _weatherData2);

      String _weather = _weatherData.toJson();
      _weatherData2 = WeatherData.fromJson(_weather);
      expect(_weatherData2, _weatherData);
    });
  });
}
