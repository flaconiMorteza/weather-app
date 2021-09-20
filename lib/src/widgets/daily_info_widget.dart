import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../weather_provider/weather_servie.dart';
import '../helper/helper.dart';

class DailyInfoWidget extends StatelessWidget {
  const DailyInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    // final deviceSize = MediaQuery.of(context).size;
    const _textStyle = TextStyle(color: Colors.white, fontSize: 20);
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherService.weathers.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(100, 110, 100, 200),
            ),
            margin: EdgeInsets.all(5),
            width: 100,
            child: Column(
              children: [
                TextButton(
                  onPressed: null,
                  child: Text(
                    Helper.convertDate2Day(
                        weatherService.weathers[index].applicable_date),
                    style: _textStyle,
                  ),
                ),
                Image.asset(Helper.GetPng(
                    weatherService.weathers[index].weather_state_name)),
              ],
            ),
          );
        },
      ),
    );
  }
}
