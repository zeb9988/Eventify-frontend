class Weather {
  final String cityName;
  final double temperature;
  final mainCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition,
      required temprature});
  factory Weather.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw Exception('Failed to decode weather data: JSON is null');
    }

    // Check for the presence of 'Name', 'main', and 'weather' properties
    final cityName = json['name'] as String?;
    final temperature = json['main']?['temp'] as double?;
    final mainCondition = json['weather']?[0]['main'] as String?;

    // Check if any required property is null
    if (cityName == null || temperature == null || mainCondition == null) {
      throw Exception(
          'Failed to decode weather data: Missing required properties');
    }

    return Weather(
      cityName: cityName,
      temperature: temperature,
      mainCondition: mainCondition,
      temprature: null,
    );
  }
}
