import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/city_data.dart';
import '../models/weather_data.dart';

class WeatherService with ChangeNotifier {
  List<WeatherData> _weatherData = [];
  List<City> _cities = [];
  int _selectedIndex = 0;
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
      }
    } catch (ex) {
      rethrow;
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
    return [..._weatherData];
  }

  List<City> get cities {
    return [..._cities];
  }

  String? get cityName {
    _cities.isNotEmpty ? _cities[0].title : "Null";
  }

  Future<void> fetchAndSetCity([String cityName = "Berlin"]) async {
    String url =
        'https://www.metaweather.com/api/location/search/?query=$cityName';
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri, headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      });

      if (response.statusCode != 200) {
      } else {
        final extractedData = json.decode(response.body);
        final List<City> loadedCities = [];
        extractedData.forEach((prodData) {
          loadedCities.add(City(
            title: prodData['title'],
            woeid: prodData['woeid'],
          ));
        });
        _cities = loadedCities;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }
}
