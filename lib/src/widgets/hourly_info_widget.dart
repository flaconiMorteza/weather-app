import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../weather_provider/weather_servie.dart';

class HourlyInfoWidget extends StatelessWidget {
  const HourlyInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    // final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(80, 90, 120, 150),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 30),
            ),
            onPressed: null,
            child: Text(
              weatherService.cityName ?? "Berlin",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
