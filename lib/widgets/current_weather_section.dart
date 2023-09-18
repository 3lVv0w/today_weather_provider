import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_weather/controller/today_weather_controller.dart';
import 'package:today_weather/models/weather_data.dart';
import 'package:today_weather/widgets/Weather.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: context.watch<TodayWeatherController>().weatherData != null,
          child: Weather(weather: context.watch<TodayWeatherController>().weatherData),
        ),
      ),
    );
  }
}
