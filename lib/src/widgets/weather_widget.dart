import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../weather_provider/weather_servie.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    final weatherData = weatherService.weatherData;
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          return await weatherService.fetchAndSetWeather();
        },
        child: ListView(
          children: [
            Center(
              child: Container(
                width: deviceSize.width > 700
                    ? deviceSize.width * 3 / 4
                    : deviceSize.width - 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
