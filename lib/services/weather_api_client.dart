import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app_mobile_flutter/model/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    var endPoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric");
    var response = await http.get(endPoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }

  Future<Weather>? getCurrentWeatherFromLatAndLon(
      double lat, double lon) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    var endPoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric");

    var response = await http.get(endPoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}
