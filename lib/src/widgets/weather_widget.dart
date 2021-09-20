import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../weather_provider/weather_servie.dart';
import 'daily_info_widget.dart';
import 'general_info_widget.dart';
import 'hourly_info_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    //final weatherData = weatherService.weatherData;
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            const Color.fromRGBO(50, 50, 180, 100)
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
            GeneralInfoWidget(),
            HourlyInfoWidget(),
            DailyInfoWidget(),
          ],
        ),
      ),
    );
  }
}
