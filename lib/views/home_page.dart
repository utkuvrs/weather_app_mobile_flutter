import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_mobile_flutter/main.dart';

import 'package:weather_app_mobile_flutter/services/weather_api_client.dart';
import 'package:weather_app_mobile_flutter/views/additional_information.dart';
import 'package:weather_app_mobile_flutter/views/current_weather.dart';
import 'location_page.dart';

import '../model/weather_model.dart';

class HomePage extends StatefulWidget {
  final String locationName;
  const HomePage({Key? key, required this.locationName}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

Weather data = Weather();

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();

  @override
  void initState() {
    super.initState();
    client.getCurrentWeather("Georgia");
  }

  Future<void> getData() async {
    data = (await client.getCurrentWeather(widget.locationName))!;
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
        drawer: const NavigationDrawer(),
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

                  currentWeather("${data.temp}", "${data.cityName}"),
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
                  Center(
                    child: Container(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 200,
                            color: Colors.blue[600],
                            child: const Center(
                                child: Text(
                              'Item 1',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                          ),
                          Container(
                            width: 200,
                            color: Colors.green[500],
                            child: const Center(
                                child: Text(
                              'Item 2',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                          ),
                          Container(
                            width: 200,
                            color: Colors.orange[400],
                            child: const Center(
                                child: Text(
                              'Item 3',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                          ),
                          Container(
                            width: 200,
                            color: Colors.cyan[300],
                            child: const Center(
                                child: Text(
                              'Item 4',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                    ),
                  )
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.search_outlined),
              title: const Text("Search"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LocationPage())),
            ),
            ListTile(
              leading: const Icon(Icons.door_sliding_outlined),
              title: const Text("Sign out"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      );
}
