class Weather {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  int? pressure;
  double? feelsLike;
  double? longitude;
  double? latitude;

  Weather(
      {this.cityName,
      this.temp,
      this.wind,
      this.humidity,
      this.feelsLike,
      this.pressure,
      this.latitude,
      this.longitude});

  // We are going to parse JSON data to weather models,
  // and after that we'll use it on the backend.

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"].toDouble();
    humidity = json["main"]["humidity"];
    feelsLike = json["main"]["feels_like"];
    pressure = json["main"]["pressure"];
    latitude = json["coord"]["lat"];
    longitude = json["coord"]["lon"];
  }
}
