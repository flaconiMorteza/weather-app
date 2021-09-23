import 'package:esi_weather_app/src/models/city_data.dart';
import 'package:esi_weather_app/src/screens/search_city_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:esi_weather_app/src/weather_provider/city_service.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
    'Should display the cities in the list',
    (WidgetTester tester) async {
      // Arrange
      final CityService _cityService = CityService();

      City city1 = City(title: 'Berlin', woeid: 638242);
      City city2 = City(title: 'London', woeid: 638341);

      _cityService.testAddCity(city1);
      _cityService.testAddCity(city1);
      _cityService.testAddCity(city1);
      _cityService.testAddCity(city2);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => _cityService,
              ),
            ],
            child: const SearchCityScreen(),
          ),
        ),
      );

      _cityService.testAddCity(city2);
      await tester.pump();
      // Assert
      expect(find.text('Berlin'), findsNWidgets(3));
      expect(find.text('London'), findsNWidgets(2));

      _cityService.resetCities();
      await tester.pump();
      expect(find.text('Berlin'), findsNWidgets(0));
      expect(find.text('London'), findsNWidgets(0));
    },
  );
}
