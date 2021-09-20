import 'package:flutter/material.dart';

import '../models/weather_data.dart';

class WeatherService with ChangeNotifier {
  late WeatherData _weatherData;
  Future<void> fetchAndSetWeather([String cityName = "Berlin"]) async {
    await Future.delayed(const Duration(seconds: 4), () {});
    notifyListeners();
    //  _authTimer = Timer(Duration(seconds: 10), tempRemove);
  }

  WeatherData get weatherData => _weatherData;
}
