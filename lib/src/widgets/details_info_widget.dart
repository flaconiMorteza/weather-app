import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/helper.dart';
import '../weather_provider/weather_servie.dart';

class DetailsInfoWidget extends StatelessWidget {
  const DetailsInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    final deviceSize = MediaQuery.of(context).size;
    const _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'WDF',
    );
    return Container(
      margin: const EdgeInsets.all(10),
      height: deviceSize.height / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                Helper.getStringDate(weatherService
                    .weathers[weatherService.selectedIndex].applicable_date),
                style: _textStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherService
                        .weathers[weatherService.selectedIndex].humidity
                        .toString(),
                    style: _textStyle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.wash_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherService
                        .weathers[weatherService.selectedIndex].wind_speed!
                        .toInt()
                        .toString(),
                    style: _textStyle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.air,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherService
                        .weathers[weatherService.selectedIndex].air_pressure!
                        .toInt()
                        .toString(),
                    style: _textStyle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.compress_sharp,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
