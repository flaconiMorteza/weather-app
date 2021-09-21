import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

import 'src/weather_provider/weather_servie.dart';
import 'src/weather_provider/city_service.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => WeatherService()),
    ChangeNotifierProvider(create: (_) => CityService()),
  ], child: MyApp()));
}
