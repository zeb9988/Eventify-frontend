
import 'package:eventify/models/WeatherModel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Weather/Services/weatherServices.dart';

class Messages extends StatefulWidget {
  static const String id = '/Message';
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  //api key
  final _weatherService= WeatherService('3cf84e3b2bee2c16cf92772b2e51d40e');
  Weather? _weather;
  // fetvh weather
  _fetchWeather () async{
    //get current city
    String? cityName=await _weatherService.getCurrentCity();
    print('${cityName}wffsff');
    //get weather for city
    try{
      final weather=await _weatherService.getWeather(cityName!);
      setState(() {
        _weather=weather;
      });
    }
    //any error
    catch(e){
      print(e);
    }
  }
  //weather animation
String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'assets/animation/sunny.json'; //default to sunny
  switch (mainCondition.toLowerCase()){
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return '/assets/animation/cloud.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/animation/rain.json';
    case 'thunderstorm':
      return 'assets/animation/thunder.json';
    case 'clear':
      return 'assets/animation/sunny.json';
    default:
      return 'assets/animation/sunny.json';
  }
}
  //initstate
  @override
  void initState() {
    super.initState();
    //fetch weather from start
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body:

        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                // city name
            Text(_weather?.cityName ?? "loading city..."),
            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temprature
            Text('${_weather?.temperature.round()}C'),
            //weather condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
          )
      );
  }
}
