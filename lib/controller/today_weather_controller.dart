import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:today_weather/models/forecast_data.dart';
import 'package:today_weather/models/weather_data.dart';

class TodayWeatherController extends ChangeNotifier {
  bool? _isServiceNotEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  WeatherData? _weatherData;
  ForecastData? _forecastData;
  String? _message;
  bool _isLoading = false;

  WeatherData? get weatherData => _weatherData;
  ForecastData? get forecastData => _forecastData;
  bool? get isLoading => _isLoading;
  String? get message => _message;

  Location _location = Location();
  Dio _dio = Dio();

  Future<void> loadWeather() async {
    String apiKey = dotenv.env["API_KEY"]!;

    try {
      _isServiceNotEnabled = await _location.serviceEnabled();
      if (!_isServiceNotEnabled!) {
        _isServiceNotEnabled = await _location.requestService();
        if (!_isServiceNotEnabled!) {
          return;
        }
      }

      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationData = await _location.getLocation();

      final double? lat = _locationData!.latitude;
      final double? lon = _locationData!.longitude;
      // TODO: add Await to each function here to get the number print in the order
      _weatherData = await _fetchAndSetWeatherData(apiKey, lat, lon);
      _forecastData = await _fetchAndSetForcastingData(apiKey, lat, lon);
    } on PlatformException catch (e, _) {
      if (e.code == 'PERMISSION_DENIED') {
        _message = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        _message = 'Permission denied - please ask the user to enable it from the app settings';
      }

      _locationData = null;
    }
    notifyListeners();
  }

  Future<WeatherData?> _fetchAndSetWeatherData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    final weatherResponse = await _dio.get(
      'https://api.openweathermap.org/data/2.5/weather?appid=$apiKey&lat=${lat.toString()}&lon=${lon.toString()}',
    );
    if (weatherResponse.statusCode == 200) {
      return WeatherData.fromJson(weatherResponse.data);
    } else {
      return null;
    }
  }

  Future<ForecastData?> _fetchAndSetForcastingData(
    String apiKey,
    double? lat,
    double? lon,
  ) async {
    final forecastResponse = await _dio.get(
      'https://api.openweathermap.org/data/2.5/forecast?appid=$apiKey&lat=${lat?.toString()}&lon=${lon?.toString()}',
    );
    if (forecastResponse.statusCode == 200) {
      return ForecastData.fromJson(forecastResponse.data);
    } else {
      return null;
    }
  }

  void toggelLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
