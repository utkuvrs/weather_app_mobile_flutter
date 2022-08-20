// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_mobile_flutter/services/weather_api_client.dart';

import 'package:weather_app_mobile_flutter/model/weather_model.dart';
import 'home_page.dart';

class LocationPage extends StatefulWidget {
  late Future<Weather>? weather;
  LocationPage({Key? key}) : super(key: key);
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final cityNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: const Color(0xFFf9f9f9),
        appBar: AppBar(
          backgroundColor: const Color(0XFFf9f9f9),
          elevation: 0.0,
          title: const Text(
            "Search",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: Colors.black,
          ),
        ),
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: cityNameController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: "City"),
                ),
                const SizedBox(
                  height: 4,
                ),
                ElevatedButton.icon(
                    onPressed: () => getWeatherInfoOfCity(),
                    icon: const Icon(Icons.search_outlined),
                    label: const Text("Search", style: TextStyle(fontSize: 24)),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50))),
                const SizedBox(
                  height: 4,
                ),
                ElevatedButton.icon(
                    onPressed: () => getWeatherInfoFromLocation(),
                    icon: const Icon(Icons.map_outlined),
                    label: const Text("Locate", style: TextStyle(fontSize: 24)),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getWeatherInfoFromLocation() async {
    // First, check if GPS is enabled
    bool servicestatus = await Geolocator.isLocationServiceEnabled();

    if (servicestatus) {
      print("GPS service is enabled");
    } else {
      print("GPS service is disabled.");
    }

    // Secondly, check if perms are given by end-user for the location

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      }
      // If end-user gives permission, get position of the end-user.
      else {
        print("GPS Location service is granted");
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        print(position.longitude);
        print(position.latitude);
        widget.weather = WeatherApiClient().getCurrentWeatherFromLatAndLon(
            position.latitude, position.longitude);
        // Lastly render home page.
        renderHomePage();
      }
    } else {
      print("GPS Location permission granted.");

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(position.longitude);
      print(position.latitude);
      widget.weather = WeatherApiClient().getCurrentWeatherFromLatAndLon(
          position.latitude, position.longitude);
      // Lastly render home page.
      renderHomePage();
    }
  }

  Future getWeatherInfoOfCity() async {
    try {
      widget.weather =
          WeatherApiClient().getCurrentWeather(cityNameController.text.trim());
      renderHomePage();
    } catch (e) {
      print(e);
    }
  }

  Future renderHomePage() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(
              locationName: cityNameController.text.trim(),
            )));
  }
}
