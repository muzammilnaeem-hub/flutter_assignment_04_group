class Weather {
  final double currentTemp;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String cityName;

  Weather({
    required this.currentTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.cityName,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];

    return Weather(
      currentTemp: main['temp'].toDouble(),
      minTemp: main['temp_min'].toDouble(),
      maxTemp: main['temp_max'].toDouble(),
      description: weather['description'],
      cityName: json['name'],
    );
  }
}
