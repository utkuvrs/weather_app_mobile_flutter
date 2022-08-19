# Weather Application - Flutter

# Views - Frontend

# Model - Backend

```dart
class Weather {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  int? pressure;
  double? feelsLike;

  Weather(
      {this.cityName,
      this.temp,
      this.wind,
      this.humidity,
      this.feelsLike,
      this.pressure});

  // We are going to parse JSON data to weather models,
  // and after that we'll use it on the backend.

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"].toDouble();
    humidity = json["main"]["humidity"];
    feelsLike = json["main"]["feels_like"];
    pressure = json["main"]["pressure"];
  }
}
```

# API - Weather Data

```dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_mobile_flutter/model/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endPoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=9831b85e6410d2ae724f4f85ddbbde84&units=metric");
    var response = await http.get(endPoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}
```

# Firebase - Authentication

> Firebase is our go-to web-database for quick app deployment. It’s easy to use and create.
> 
1. Let’s initialize our Firebase instance

```dart
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}
```

1. Check if the input user has given matches any in the Firebase Auth database, if so enter.

```dart
Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
```

1. Check if the user has connected or not, if connected load Home Page

```dart
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginWidget();
          }
        },
      ),
    );
  }
}
```
