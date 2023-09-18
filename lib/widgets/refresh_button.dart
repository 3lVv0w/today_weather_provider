import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_weather/controller/today_weather_controller.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: context.watch<TodayWeatherController>().isLoading!,
        replacement: IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh',
          onPressed: () async {
            context.read<TodayWeatherController>().toggelLoading();

            await context.read<TodayWeatherController>().loadWeather();

            context.read<TodayWeatherController>().toggelLoading();
          },
          color: Colors.white,
        ),
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
  }
}
