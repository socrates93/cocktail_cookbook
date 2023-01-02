import 'package:dio/dio.dart';

class DioConfig {
  static late Dio _dio;

  DioConfig() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://www.thecocktaildb.com/api/json/v1/1',
    );

    _dio = Dio(options);
  }

  static Dio get instance => _dio;
}
