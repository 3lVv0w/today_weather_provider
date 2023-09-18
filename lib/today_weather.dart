import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_weather/controller/today_weather_controller.dart';
import 'package:today_weather/widgets/current_weather_section.dart';
import 'package:today_weather/widgets/forecast_weather_section.dart';
import 'package:today_weather/widgets/refresh_button.dart';

class TodayWeather extends StatefulWidget {
  const TodayWeather({super.key});

  @override
  State<StatefulWidget> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await context.read<TodayWeatherController>().loadWeather();
      Provider.of<TodayWeatherController>(context).loadWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    TodayWeatherController read = context.read<TodayWeatherController>();
    TodayWeatherController watch = context.watch<TodayWeatherController>();
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                CurrentWeather(),
                RefreshButton(),
                ForecaseWeaterSection(),
                read.

              ],
            ),
          ),
        ),
      ),
    );
  }
}
