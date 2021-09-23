import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/city_data.dart';

// ignore: slash_for_doc_comments
/**************************Morteza*********************************
This class provides the ability for city searching in cityScreen.
By calling notifyListeners, all listener update their data from
class. Also cityService gets information from remote server by http.
******************************************************************/

class CityService with ChangeNotifier {
  List<City> _cities = [];

  //Fetching city information by given character
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

  //When CityScreen finished its work, all city data is deleted by this function.
  void resetCities() {
    _cities.clear();
    notifyListeners();
  }

  /* =========>Important: This part of code are developed just for testing<=========== */
  void testAddCity(City city) {
    _cities.add(city);
    notifyListeners();
  }
}
