import 'package:esi_weather_app/src/models/city_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../weather_provider/city_service.dart';

class SearchCityScreen extends StatelessWidget {
  SearchCityScreen({Key? key}) : super(key: key);
  static const routeName = '/City';

  @override
  Widget build(BuildContext context) {
    final cityService = Provider.of<CityService>(context);
    final cities = cityService.cities;
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Select a city',
          style: TextStyle(
            fontFamily: 'PinyonScript',
            fontSize: 25,
          ),
        )),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/BK_Image.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: [
            TextField(
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'Type the city name.'),
              onChanged: (city) async {
                if (city.length < 3) return;

                try {
                  return await Provider.of<CityService>(context, listen: false)
                      .doNewsearch(city);
                } catch (ex) {
                  final snackBar = SnackBar(
                      content: Center(
                          child: Text(
                    'Server connection problem. Please check your data!',
                    textAlign: TextAlign.center,
                  )));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            Center(
              child: Container(
                width: deviceSize.width > 700
                    ? deviceSize.width * 3 / 4
                    : deviceSize.width - 5,
                child: GridView.builder(
                  physics: ScrollPhysics(), // to disable GridView's scrolling
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
                      child: cityItem(cities[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Container cityItem(City citi) {
  return Container(
    color: Colors.red,
  );
}
