import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/helper.dart';
import '../weather_provider/weather_servie.dart';

// ignore: slash_for_doc_comments
/**************************Morteza*********************************
This main root of this widget is WeatherWidget. This widget is shown
just in horizontal position. All needed weather information for a day
are shown in this widget. This widget's structure is similar to the
GeneralInfoWidget.Just some needed informations are added to the end
of the main column widget. I'm Sorry but lots of columns and rows are
intertwined together. One day i will refactor this long widget!!!!
******************************************************************/

class LandGeneralInfoWidget extends StatelessWidget {
  const LandGeneralInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    const _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontFamily: 'PinyonScript',
    );
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      height: deviceSize.height / 3,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(100, 110, 100, 200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110,
                    height: 60,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        weatherService.city.title ?? "Null",
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 30,
                            fontFamily: 'PinyonScript'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    weatherService.weathers[weatherService.selectedIndex]
                            .weather_state_name ??
                        "unknown",
                    style: const TextStyle(
                        fontFamily: 'PinyonScript',
                        color: Colors.white,
                        fontSize: 30),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: deviceSize.height / 8,
                width: deviceSize.height / 8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Helper.getPng(weatherService
                        .weathers[weatherService.selectedIndex]
                        .weather_state_name)),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              weatherService.selectedIndex == 0
                  ? SizedBox(
                      width: 110,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          weatherService.weathers[weatherService.selectedIndex]
                                  .the_temp!
                                  .toInt()
                                  .toString() +
                              "°",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontFamily: 'PinyonScript',
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_upward_sharp,
                        color: Colors.white,
                      ),
                      Text(
                        weatherService.weathers[weatherService.selectedIndex]
                                .max_temp!
                                .toInt()
                                .toString() +
                            "°",
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
                      ),
                      Text(
                        weatherService.weathers[weatherService.selectedIndex]
                                .min_temp!
                                .toInt()
                                .toString() +
                            "°",
                        style: _textStyle,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
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
