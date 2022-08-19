import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:weather_app_mobile_flutter/model/weather_model.dart';
import 'home_page.dart';

class LocationPage extends StatefulWidget {
  late GeoData geoData;
  final Weather weather;
  LocationPage({Key? key, required this.weather}) : super(key: key);
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: HomePage(
        locationName: widget.geoData.city,
      ),
    );
  }

  Future getLocation() async {
    widget.geoData = await Geocoder2.getDataFromCoordinates(
        latitude: (widget.weather.latitude)!,
        longitude: (widget.weather.longitude)!,
        googleMapApiKey: "AIzaSyDeGZZPpMXrcV6YNkpjemWTE1i3HFMNCKI");
  }
}
