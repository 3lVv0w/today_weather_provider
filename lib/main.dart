import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:today_weather/controller/today_weather_controller.dart';
import 'package:today_weather/today_weather.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(
    MultiBlocProvicer(
      providers: [
        ChangeNotifierProvider(create: (_) => TodayWeatherController())
      ],
      child: const TodayWeather(),
    ),
  );
}
