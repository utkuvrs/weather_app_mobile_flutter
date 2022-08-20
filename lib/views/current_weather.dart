import 'package:flutter/material.dart';

Widget currentWeather(String temp, String location) {
  if (double.parse(temp) > 25.0) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wb_sunny_rounded,
            color: Colors.orangeAccent,
            size: 64.0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            "$temp",
            style: const TextStyle(fontSize: 46.0),
          ),
          const SizedBox(height: 10),
          Text(
            "$location",
            style: const TextStyle(fontSize: 18.0, color: Color(0xFF5a5a5a)),
          ),
        ],
      ),
    );
  }
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.wb_cloudy_rounded,
          color: Colors.orangeAccent,
          size: 64.0,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          "$temp",
          style: const TextStyle(fontSize: 46.0),
        ),
        const SizedBox(height: 10),
        Text(
          "$location",
          style: const TextStyle(fontSize: 18.0, color: Color(0xFF5a5a5a)),
        ),
      ],
    ),
  );
}
