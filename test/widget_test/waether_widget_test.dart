import 'package:esi_weather_app/src/models/city_data.dart';
import 'package:esi_weather_app/src/models/weather_data.dart';
import 'package:esi_weather_app/src/weather_provider/weather_servie.dart';
import 'package:esi_weather_app/src/widgets/general_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets(
    'Should display the items in weather widget',
    (WidgetTester tester) async {
      // Arrange
      final WeatherService _weatherService = WeatherService();

      const String strWeatherJson = '''
    {
      "weather_state_name":"Heavy Cloud",
      "applicable_date":"2021-09-23",
      "min_temp":12.0,
      "max_temp":21.675,
      "the_temp":20.1,
      "wind_speed":6.719674059243352,
      "air_pressure":1020.5,
      "humidity":70
  }
  ''';
      WeatherData _weatherData = WeatherData.fromJson(strWeatherJson);
      expect(_weatherData.the_temp, 20.1);

      City _city = City(title: 'Berlin', woeid: 638242);

      _weatherService.testSetCity(_city);
      _weatherService.testAddWeather(_weatherData);
      _weatherService.testAddWeather(_weatherData);
      _weatherService.testAddWeather(_weatherData);
      _weatherService.testAddWeather(_weatherData);
      _weatherService.testAddWeather(_weatherData);
      _weatherService.testAddWeather(_weatherData);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => _weatherService,
              ),
            ],
            child: const GeneralInfoWidget(),
          ),
        ),
      );

      _weatherService.testAddWeather(_weatherData);
      await tester.pump();
      // Assert
      expect(find.text('Berlin'), findsNWidgets(1));
      expect(find.text('Heavy Cloud'), findsNWidgets(1));
    },
  );
}
