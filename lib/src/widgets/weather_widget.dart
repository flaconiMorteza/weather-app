import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../weather_provider/weather_servie.dart';
import '../screens/search_city_screen.dart';
import 'daily_info_widget.dart';
import 'general_info_widget.dart';
import 'details_info_widget.dart';
import 'land_general_info_widget.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  bool celsius = true;
  bool _isLoading = false;
  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  var snackBar = const SnackBar(
      content: Center(
          child: Text(
    'Server connection problem. Please check your data!',
    textAlign: TextAlign.center,
  )));

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;

    var _vertical = deviceSize.height > deviceSize.width;

    return LoadingOverlay(
      isLoading: _isLoading,
      progressIndicator: const CircularProgressIndicator(
        color: Colors.amber,
      ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/BK_Image.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            try {
              return await weatherService.fetchAndSetWeather();
            } catch (ex) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: /*_isLoading
              ? CircularProgressIndicator()
              : */
              Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          celsius = !celsius;
                          Provider.of<WeatherService>(context, listen: false)
                              .setCelsius(celsius);
                        });
                      },
                      child: Text(
                        '°F',
                        style: TextStyle(
                          color: celsius ? Colors.grey : Colors.yellowAccent,
                          fontFamily: 'WDF',
                          fontSize: 20,
                        ),
                      )),
                  searchBox(),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          celsius = !celsius;
                          Provider.of<WeatherService>(context, listen: false)
                              .setCelsius(celsius);
                        });
                      },
                      child: Text(
                        '°C',
                        style: TextStyle(
                          color: celsius ? Colors.yellowAccent : Colors.grey,
                          fontFamily: 'WDF',
                          fontSize: 20,
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: _vertical
                      ? ListView(
                          children: const [
                            GeneralInfoWidget(),
                            DetailsInfoWidget(),
                            DailyInfoWidget(),
                          ],
                        )
                      : ListView(
                          children: [
                            LandGeneralInfoWidget(),
                            DailyInfoWidget()
                          ],
                        )),
            ],
          ),
        ),
      ),
    );
  }

  Container searchBox() {
    return Container(
        width: 210,
        child: TextButton.icon(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchCityScreen()),
            );
            if (result != null) {
              setState(() {
                _isLoading = true;
              });
              try {
                await Provider.of<WeatherService>(context, listen: false)
                    .setCity(result);
              } catch (ex) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              setState(() {
                _isLoading = false;
              });
            }
          },
          label: const Text(
            'Tap for new city',
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 14,
              fontFamily: 'WDF',
            ),
          ),
        ));
  }
}
