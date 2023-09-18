import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_weather/controller/today_weather_controller.dart';
import 'package:today_weather/widgets/Weather.dart';

class ForecaseWeaterSection extends StatelessWidget {
  const ForecaseWeaterSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          // height: 200.0,
          child: Visibility(
            visible: context.watch<TodayWeatherController>().forecastData != null,
            child: ListView.builder(
              itemCount: context.watch<TodayWeatherController>().forecastData?.list.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Weather(
                    weather: context.watch<TodayWeatherController>().forecastData?.list[index],
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
