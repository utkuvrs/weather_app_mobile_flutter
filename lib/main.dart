import 'package:flutter/material.dart';
import 'package:weather_app_mobile_flutter/views/current_weather.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [currentWeather(Icons.wb_sunny_rounded, "26.3", "Georgia")],
      ),
    );
  }
}
