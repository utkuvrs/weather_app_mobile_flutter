import 'package:flutter/material.dart';
import 'package:weather_app_mobile_flutter/services/weather_api_client.dart';
import 'package:weather_app_mobile_flutter/views/additional_information.dart';
import 'package:weather_app_mobile_flutter/views/current_weather.dart';

import 'model/weather_model.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather data = Weather();
  @override
  void initState() {
    super.initState();
    client.getCurrentWeather("Georgia");
  }

  Future<void> getData() async {
    data = (await client.getCurrentWeather("Samsun"))!;
  }

  @override
  Widget build(BuildContext context) {
    // Starting with the UI of the app.
    return Scaffold(
        backgroundColor: const Color(0xFFf9f9f9),
        appBar: AppBar(
          backgroundColor: const Color(0XFFf9f9f9),
          elevation: 0.0,
          title: const Text(
            "Weather App",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: Colors.black,
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // When the connection is over,
              // display the necessary data.
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Let's create custom widgets for the app.

                  currentWeather(Icons.wb_sunny_rounded, "${data.temp}",
                      "${data.cityName}"),
                  const SizedBox(height: 60),
                  const Text(
                    "Additional Information",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xdd212121),
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20.0,
                  ),

                  additionalInformation("${data.wind}", "${data.humidity}",
                      "${data.pressure}", "${data.feelsLike}"),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ));
  }
}
