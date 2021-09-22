import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../weather_provider/city_service.dart';
import '../models/city_data.dart';

class SearchCityScreen extends StatefulWidget {
  const SearchCityScreen({Key? key}) : super(key: key);
  static const routeName = '/City';

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  var _isLoading = false;
  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cityService = Provider.of<CityService>(context);
    final cities = cityService.cities;
    final deviceSize = MediaQuery.of(context).size;
    var _textStyle =
        const TextStyle(color: Colors.white, fontFamily: 'WDF', fontSize: 25);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'Select a city',
          style: TextStyle(
            fontFamily: 'PinyonScript',
            fontSize: 25,
          ),
        )),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.amber,
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/BK_City.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 25, left: 25),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: _textStyle,
                  decoration: const InputDecoration(
                    hintText: 'Type the city name.',
                    hintStyle:
                        TextStyle(fontSize: 20.0, color: Colors.blueGrey),
                  ),
                  onChanged: (city) async {
                    if (city.length < 3) {
                      Provider.of<CityService>(context, listen: false)
                          .resetCities();
                      return;
                    }
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      await Provider.of<CityService>(context, listen: false)
                          .doNewsearch(city);
                    } catch (ex) {
                      var snackBar = const SnackBar(
                          content: Text(
                        'Server connection problem. Please check your data!',
                        textAlign: TextAlign.center,
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
              ),
              Center(
                child: Container(
                  width: deviceSize.width > 700
                      ? deviceSize.width * 3 / 4
                      : deviceSize.width - 5,
                  child: GridView.builder(
                    physics:
                        const ScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: deviceSize.width > 700 ? 3 : 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    itemCount: cities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                        value: cityService,
                        child: cityItem(context, cities[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () async {
          Provider.of<CityService>(context, listen: false).resetCities();
          Navigator.pop(context);
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

InkWell cityItem(BuildContext context, City city) {
  var _textStyle =
      const TextStyle(color: Colors.white, fontFamily: 'WDF', fontSize: 20);
  return InkWell(
    child: Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(100, 110, 100, 200),
      ),
      child: Center(
        child: Text(
          city.title ?? "Null",
          style: _textStyle,
        ),
      ),
    ),
    onTap: () async {
      Provider.of<CityService>(context, listen: false).resetCities();
      Navigator.pop(context, city);
    },
  );
}
