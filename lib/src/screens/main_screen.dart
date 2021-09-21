import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../weather_provider/weather_servie.dart';
import '../widgets/weather_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _isError = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        tryFetchWeatherData();
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void tryFetchWeatherData() {
    _isLoading = true;
    Provider.of<WeatherService>(context, listen: false)
        .fetchAndSetWeather()
        .then((_) {
      setState(() {
        _isLoading = false;
        _isError = false;
      });
    }).catchError((Error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    const _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: 'WDF',
    );
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'flaconi Weather App',
          style: TextStyle(
            fontFamily: 'PinyonScript',
            fontSize: 25,
          ),
        )),
        /*actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],*/
      ),
      body: _isLoading
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/BK_Image.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : (_isError
              ? Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/BK_Image.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CircularProgressIndicator(),
                        Text(
                          "Server connection problem",
                          style: _textStyle,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                tryFetchWeatherData();
                              });
                            },
                            child: Text("Try again", style: _textStyle)),
                        ElevatedButton(
                            onPressed: () => exit(0),
                            child: Text("Exit App", style: _textStyle)),
                      ],
                    ),
                  ),
                )
              : WeatherWidget()),
    );
  }
}
