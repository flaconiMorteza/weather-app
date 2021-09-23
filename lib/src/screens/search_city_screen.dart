import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../weather_provider/city_service.dart';
import '../models/city_data.dart';

// ignore: slash_for_doc_comments
/**************************Morteza*********************************
This StatefulWidget is the screen of searching city name. Because of
simplicity all needed widgets are embedded in this class. for the sake
of supporting the vertical and horizontal, some extra conditions are
 checked and some sizes are changed during the widget life cycle.
******************************************************************/

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
      //By using LoadingOverlay, we can show the wait progress indicator
      //over the screen. isLoading and child is required in this widget.
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
                  key: const ValueKey('text.search'),
                  textAlign: TextAlign.center,
                  style: _textStyle,
                  decoration: const InputDecoration(
                    hintText: 'Type the city name.',
                    hintStyle:
                        TextStyle(fontSize: 20.0, color: Colors.blueGrey),
                  ),
                  //Over the 2 character every change in TextField fires the
                  //new search and isLoading set to true until search was finished.
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
                      showSnackBar(context,
                          'Server connection problem. Please check your data!');
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
              ),
              Center(
                child: Container(
                  //Here the width of the container is changed by the deviceSize.
                  width: deviceSize.width > 700
                      ? deviceSize.width * 3 / 4
                      : deviceSize.width - 5,
                  child: GridView.builder(
                    physics:
                        const ScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //Here the count of city boxes are determine by device width
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
                        //each fetched city is shown in cityItem
                        //by loading the cities information in CityService
                        //notifyListeners is called and city boxes are create here
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
        key: const ValueKey('button.back'),
        onPressed: () async {
          Provider.of<CityService>(context, listen: false).resetCities();
          Navigator.pop(context);
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

//Each city is shown in a box. This boxes are cityItem.
InkWell cityItem(BuildContext context, City city) {
  var _textStyle =
      const TextStyle(color: Colors.white, fontFamily: 'WDF', fontSize: 20);
  //InkWell is used for enabling for onTap event. By tapping on a city
  //city object is return to the weather widget to update the weather information
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
      //Here by tapping navigation pop and city information is backed to the weather widget.
      Provider.of<CityService>(context, listen: false).resetCities();
      Navigator.pop(context, city);
      //By pop we back to the WeatherWidget class
    },
  );
}
