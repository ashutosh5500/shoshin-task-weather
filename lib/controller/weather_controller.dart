import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app_shoshin/model/weather_model.dart';

class WeatherController extends GetxController {
  WeatherModel? weatherModel;

  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print('kkkkkkkkkkkk}1');

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    print('kkkkkkkkkkkk}2');

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position? position = await Geolocator.getLastKnownPosition();

    return position;
  }

  String weatherDesc(int code) {
    String res = '';
    if (code == 0) {
      res = 'Clear sky';
    } else if (code > 0 && code < 4) {
      res = 'Mainly clear, partly cloudy, and overcast';
    } else if (code > 44 && code < 49) {
      res = 'Fog and depositing rime fog';
    } else if (code > 50 && code < 56) {
      res = 'Drizzle: Light, moderate, and dense intensity';
    } else if (code > 55 && code < 58) {
      res = 'Freezing Drizzle: Light and dense intensity';
    } else if (code > 60 && code < 66) {
      res = 'Rain: Slight, moderate and heavy intensity';
    } else if (code > 65 && code < 68) {
      res = 'Freezing Rain: Light and heavy intensity';
    } else if (code > 70 && code < 76) {
      res = 'Snow fall: Slight, moderate, and heavy intensity';
    } else if (code == 77) {
      res = 'Snow grains';
    } else if (code > 79 && code < 83) {
      res = 'Rain showers: Slight, moderate, and violent';
    } else if (code > 84 && code < 87) {
      res = 'Snow showers slight and heavy';
    } else if (code == 95) {
      res = 'Thunderstorm: Slight or moderate';
    } else if (code > 95 && code < 100) {
      res = 'Thunderstorm with slight and heavy hail';
    }
    return res;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // determinePosition();
  }
}
