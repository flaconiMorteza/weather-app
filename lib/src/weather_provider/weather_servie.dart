import 'package:flutter/material.dart';

class WeatherService with ChangeNotifier {
  Future<void> fetchAndSetWeather([String cityName = "Berlin"]) async {
    await Future.delayed(const Duration(seconds: 4), () {});
    notifyListeners();
    //  _authTimer = Timer(Duration(seconds: 10), tempRemove);
  }
}
