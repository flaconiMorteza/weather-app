import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/city_data.dart';
import '../models/weather_data.dart';

// ignore: slash_for_doc_comments
/**************************Morteza*********************************
This class provides the ability for fetching weather data. By calling
notifyListeners, all listener update their data from class. Also
WeatherService gets informations from remote server by http.
******************************************************************/

class WeatherService with ChangeNotifier {
  late Future<SharedPreferences> _prefs;
  WeatherService() {
    _prefs = SharedPreferences.getInstance();
    loadCity();
  }

  List<WeatherData> _weatherData = [];
  List<WeatherData> _fWeatherData = [];

  int _selectedIndex = 0;
  bool _celsius = true;
  City _city = City(title: "Berlin", woeid: 638242);

  //By http get method the weather information fetched from server
  //In this project only consolidated_weather is needed and WeatherData
  //is created and added to the private list in this function.
  Future<void> fetchAndSetWeather() async {
    try {
      int woeid = _city.woeid ?? 638242;
      String url = 'https://www.metaweather.com/api/location/$woeid/';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

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
        await saveCity();
        convert2Farenhite();
      }
    } catch (ex) {
      throw Exception('Server response problem!');
    } finally {
      notifyListeners();
    }
  }

  //New city object pass to this class by this funtion.
  //due to project requirements weather data is fetched immediately.
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

  //This method toggle between celisus and fahrenheit
  void setCelsius(bool celsius) {
    _celsius = celsius;
    notifyListeners();
  }

  //When weather data was fetched, by this function new list
  //was generated for fahrenheit requests.
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

  //At the start Time, this function was called for fetching the last
  //city that user select to view weather conditions from SharedPreferences.
  loadCity() async {
    try {
      final SharedPreferences prefs = await _prefs;
      String? strCity = prefs.getString('cityObj');
      if (strCity != null) {
        final extractedData = json.decode(strCity);

        _city = City(
          title: extractedData['title'],
          woeid: extractedData['woeid'],
        );
      }
    } catch (ex) {}
  }

  //When weather data was successfuly fetched by http get, this function
  //called to save the city information in SharedPreferences.
  Future<void> saveCity() async {
    try {
      final SharedPreferences prefs = await _prefs;
      String strCity = _city.toJson();
      await prefs.setString('cityObj', strCity);
    } catch (ex) {}
  }
}
