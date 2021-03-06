import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../weather_provider/weather_servie.dart';
import '../widgets/weather_widget.dart';

// ignore: slash_for_doc_comments
/**************************Morteza*********************************
This StatefulWidget is the main screen of the weather widget tree.
For the first time, weather data was requested by this class.
The CircularProgressIndicator is shown until data was fetched.
******************************************************************/

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

  //Here weather data was asked.
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

  //This function is called twice in this class, one by didChangeDependencies
  //and one by ElevatedButton when fetching the data or data connection has some problems.
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
          ),
        ),
      ),
      //Here data loadign is checked for showing the data or alternative CircularProgressIndicator.
      body: _isLoading
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/BK_Image.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          //Here data error is checked for showing the data or alternative error text.
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
                        const Text(
                          "Server connection problem",
                          style: _textStyle,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            setState(
                              () {
                                tryFetchWeatherData();
                              },
                            );
                          },
                          child: const Text("Try again", style: _textStyle),
                        ),
                        ElevatedButton(
                          onPressed: () => exit(0),
                          child: const Text("Exit App", style: _textStyle),
                        ),
                      ],
                    ),
                  ),
                )
              : const WeatherWidget()),
      //This floatingActionButton is used for quitting the app
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(200, 50, 50, 200),
        foregroundColor: Colors.red,
        key: const ValueKey('button.Exit'),
        child: const Icon(Icons.exit_to_app),
        onPressed: () async {
          exit(0);
        },
      ),
    );
  }
}
