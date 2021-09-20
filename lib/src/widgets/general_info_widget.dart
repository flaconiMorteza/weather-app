import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../weather_provider/weather_servie.dart';

class GeneralInfoWidget extends StatelessWidget {
  const GeneralInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);
    const textStyle = TextStyle(color: Colors.white, fontSize: 30);

    // final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
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
                children: const [
                  Text(
                    "Berlin",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 50,
                        fontFamily: 'PinyonScript'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Mon',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 35),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/png64/Clear.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                "20°",
                style: TextStyle(color: Colors.white, fontSize: 65),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.upload_outlined),
              Text(
                "28°",
                style: textStyle,
              ),
              SizedBox(
                width: 50,
              ),
              Icon(Icons.arrow_downward_sharp),
              Text(
                "15°",
                style: textStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
