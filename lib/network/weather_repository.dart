import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app_shoshin/network/api_provider.dart';

import '../controller/weather_controller.dart';
import '../model/weather_model.dart';

class WeatherRepository {
  final weatherController = Get.find<WeatherController>();

  API api = API();

  Future fetchWeather() async {
    Position position = await weatherController.determinePosition();
    String url =
        'forecast?latitude=${position.latitude}&longitude=${position.longitude}&current=temperature_2m&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset&timezone=auto&forecast_days=3';

    try {
      final res = await api.sendRequest.get(url);
      weatherController.weatherModel = WeatherModel.fromJson(res.data);
      return weatherController.weatherModel;
    } catch (e) {
      throw e;
    }
  }
}
