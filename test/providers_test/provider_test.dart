import 'package:esi_weather_app/src/models/city_data.dart';
import 'package:esi_weather_app/src/models/weather_data.dart';
import 'package:esi_weather_app/src/weather_provider/city_service.dart';
import 'package:esi_weather_app/src/weather_provider/weather_servie.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Weather Provider Test', () {
    // Arrange
    WeatherService _weatherService = WeatherService();

    const String strWeatherJson = '''
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
    WeatherData _weatherData = WeatherData.fromJson(strWeatherJson);
    expect(_weatherData.the_temp, 20.34);

    City _city1 = City(title: 'Berlin', woeid: 638242);

    _weatherService.testAddWeather(_weatherData);
    _weatherService.testAddWeather(_weatherData);
    _weatherService.testAddWeather(_weatherData);
    _weatherService.testAddWeather(_weatherData);
    _weatherService.testAddWeather(_weatherData);

    _weatherService.testSetCity(_city1);

    expect(_weatherService.weathers.length, 5);

    _weatherService.convert2Farenhite();
    _weatherService.setCelsius(false);
    expect(_weatherService.weathers[0].the_temp, 20.34 * 9 / 5 + 32);

    _weatherService.setCelsius(true);
    expect(_weatherService.weathers[0].the_temp, 20.34);
  });

  test('City Provider Test', () {
    // Arrange
    CityService _cityService = CityService();
    City _city1 = City(title: 'Berlin', woeid: 638242);

    _cityService.testAddCity(_city1);
    _cityService.testAddCity(_city1);
    _cityService.testAddCity(_city1);
    _cityService.testAddCity(_city1);

    expect(_cityService.cities.length, 4);

    _cityService.resetCities();

    expect(_cityService.cities.length, 0);
  });
}
