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

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/BK_Image.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          return await weatherService.fetchAndSetWeather();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchBox(),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView(
                children: [
                  GeneralInfoWidget(),
                  HourlyInfoWidget(),
                  DailyInfoWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container SearchBox() {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: const TextField(
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
        decoration: InputDecoration(
          hintText: "Type city name.",
          hintStyle: TextStyle(color: Colors.white, fontSize: 18),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
