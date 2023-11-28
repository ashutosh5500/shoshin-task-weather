import 'package:get/get.dart';
import 'package:weather_app_shoshin/controller/weather_controller.dart';

class DependencyInjector {
  static init() {
    Get.put(WeatherController());
  }
}
