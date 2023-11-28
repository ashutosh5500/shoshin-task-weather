import 'package:dio/dio.dart';

class API {
  final Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = "https://api.open-meteo.com/v1/";
  }

  Dio get sendRequest => _dio;
}
