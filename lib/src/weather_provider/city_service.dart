import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/city_data.dart';

class CityService with ChangeNotifier {
  List<City> _cities = [];

  Future<void> doNewsearch(String cityName) async {
    String url =
        'https://www.metaweather.com/api/location/search/?query=$cityName';
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

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
      throw Exception(error.toString());
    }
  }

  List<City> get cities {
    return [..._cities];
  }

  void resetCities() {
    _cities.clear();
    notifyListeners();
  }
}
