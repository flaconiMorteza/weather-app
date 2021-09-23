import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/helper.dart';
import '../weather_provider/weather_servie.dart';

// ignore: slash_for_doc_comments
/**************************Morteza*********************************
This main root of this widget is WeatherWidget. This widget is shown
just in vertical position.
******************************************************************/

class GeneralInfoWidget extends StatelessWidget {
  const GeneralInfoWidget({Key? key}) : super(key: key);

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
      height: deviceSize.height / 4,
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
                  //Selected city name are present here
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
                  //Weather state name are present here
                  SizedBox(
                    width: 110,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        weatherService.weathers[weatherService.selectedIndex]
                                .weather_state_name ??
                            "unknown",
                        style: const TextStyle(
                            fontFamily: 'PinyonScript',
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ),
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
              //Here the selected index is checked.
              //The first item is current day so the current tempretur should show.
              //In the other days, current tempretur is useless.
              weatherService.selectedIndex == 0
                  ? SizedBox(
                      width: 110,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          weatherService.weathers[weatherService.selectedIndex]
                                  .the_temp!
                                  .round()
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_upward_sharp,
                    color: Colors.white,
                  ),
                  //Here the max temp is presented.
                  Text(
                    weatherService
                            .weathers[weatherService.selectedIndex].max_temp!
                            .round()
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
                  //Here the min temp is presented.
                  Text(
                    weatherService
                            .weathers[weatherService.selectedIndex].min_temp!
                            .round()
                            .toString() +
                        "°",
                    style: _textStyle,
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
