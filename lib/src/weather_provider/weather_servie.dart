import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/city_data.dart';
import '../models/weather_data.dart';

class WeatherService with ChangeNotifier {
  List<WeatherData> _weatherData = [];
  List<WeatherData> _fWeatherData = [];

  int _selectedIndex = 0;
  bool _celsius = true;
  City _city = City(title: "Berlin", woeid: 638242);

  Future<void> fetchAndSetWeather() async {
    try {
      int woeid = _city.woeid ?? 638242;
      String url = 'https://www.metaweather.com/api/location/$woeid/';
      Uri uri = Uri.parse(url);
      final response = await http.get(
          uri /*, headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      }*/
          );

      if (response.statusCode != 200) {
      } else {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final weather = extractedData["consolidated_weather"];
        final List<WeatherData> loadedWeather = [];
        weather.forEach((prodData) {
          loadedWeather.add(WeatherData.fromMap(prodData));
        });
        _weatherData = loadedWeather;
        convert2Farenhite();
      }
    } catch (ex) {
      throw Exception('Server response problem!');
    } finally {
      notifyListeners();
    }
  }

  Future<void> setCity(City city) async {
    _city = city;
    await fetchAndSetWeather();
  }

  City get city => _city;

  int get selectedIndex => _selectedIndex;

  setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<WeatherData> get weathers {
    if (_celsius) {
      return [..._weatherData];
    } else {
      return [..._fWeatherData];
    }
  }

  void setCelsius(bool celsius) {
    _celsius = celsius;
    notifyListeners();
  }

  convert2Farenhite() {
    final List<WeatherData> convertedWeather = [];
    _weatherData.forEach((data) {
      convertedWeather.add(data.copyWith(
        max_temp: data.max_temp! * 9.5 + 32,
        min_temp: data.min_temp! * 9.5 + 32,
        the_temp: data.the_temp! * 9.5 + 32,
      ));
    });
    _fWeatherData = convertedWeather;
  }
}
