import 'package:flutter/material.dart';
import 'models/weather.dart';
import 'services/weather_service.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karachi Weather',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final WeatherService _weatherService = WeatherService();
  late Future<Weather> _futureWeather;

  @override
  void initState() {
    super.initState();
    _futureWeather = _weatherService.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Karachi Weather')),
      body: Center(
        child: FutureBuilder<Weather>(
          future: _futureWeather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final weather = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather.cityName,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${weather.description}',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Current: ${weather.currentTemp}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'High: ${weather.maxTemp}°C / Low: ${weather.minTemp}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              );
            } else {
              return Text('No weather data found');
            }
          },
        ),
      ),
    );
  }
}
