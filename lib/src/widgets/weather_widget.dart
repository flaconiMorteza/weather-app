import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../weather_provider/weather_servie.dart';
import 'daily_info_widget.dart';
import 'general_info_widget.dart';
import 'details_info_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context, listen: false);
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
          /*City city = City(title: 'London', woeid: 44418);
          weatherService.setCity(city);*/
          return await weatherService.fetchAndSetWeather();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            searchBox(),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView(
                children: const [
                  GeneralInfoWidget(),
                  DetailsInfoWidget(),
                  DailyInfoWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container searchBox() {
    return Container(
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: TextButton.icon(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {},
          label: const Text(
            'Tap for new city',
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 18,
              fontFamily: 'WDF',
            ),
          ),
        )
        /*const TextField(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: "Click for new city",
          hintStyle:
              TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'WDF'),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),*/
        );
  }
}
