import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../weather_provider/weather_servie.dart';
import '../helper/helper.dart';

class DailyInfoWidget extends StatelessWidget {
  const DailyInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    final deviceSize = MediaQuery.of(context).size;
    const _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'PinyonScript',
    );
    var _isVertical = deviceSize.height > deviceSize.width;
    double _height = 100;
    _isVertical
        ? _height = (deviceSize.height / 3.5)
        : _height = (deviceSize.height / 1.7);
    return Container(
      margin: const EdgeInsets.all(10),
      height: _height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherService.weathers.length,
        itemBuilder: (context, index) {
          return InkWell(
            //onTap: weatherService.setSelectedIndex(index),
            onTap: () async {
              Provider.of<WeatherService>(context, listen: false)
                  .setSelectedIndex(index);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(100, 110, 100, 200),
              ),
              margin: const EdgeInsets.all(5),
              width: _isVertical ? deviceSize.height / 8 : 110,
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
                  Image.asset(Helper.getPng(
                      weatherService.weathers[index].weather_state_name)),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_upward_sharp,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            weatherService.weathers[index].max_temp!
                                .toInt()
                                .toString(),
                            style: _textStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            weatherService.weathers[index].min_temp!
                                .toInt()
                                .toString(),
                            style: _textStyle,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
