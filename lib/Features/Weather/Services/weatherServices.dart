

import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../../../models/WeatherModel.dart';


class WeatherService{
  late bool serviceEnabled;
 late LocationPermission permission;

  static const BASE_URL= 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);


  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      // Use a try-catch block to handle potential exceptions during decoding
      try {
        // Parse the JSON and return the Weather object
        return Weather.fromJson(jsonDecode(response.body));
      } catch (e) {
        // Handle decoding errors
        throw Exception('Failed to decode weather data: $e');
      }
    } else {
      // Handle HTTP error status codes
      throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
    }
  }

  Future<String?>getCurrentCity()async{
    //get permission from user
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    //fetch the current location
    Position position= await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    //convert the location into a list  of placemark object
    List<Placemark> placemarks= await placemarkFromCoordinates(position.latitude, position.longitude);
    //extract the city name from the first placemark
    print(position.longitude);
    print(position.latitude);

    String? city= placemarks[0].locality;
    return city;
  }
}