import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  final String apiKey = 'https://api.openweathermap.org/';
  final String apiUrl =
      'https://api.openweathermap.org/data/2.5/weather?lat=25.1932024&lon=67.1554619&units=metric';

  Future<Weather> fetchWeather() async {
    final response = await http.get(Uri.parse('$apiUrl&appid=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
