import 'package:dio/dio.dart';

import 'package:cocktail_cookbook/shared/utils/constants.dart';

class DioClient {
  static late Dio _dio;

  DioClient() {
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl,
    );

    _dio = Dio(options);
  }

  Dio get instance => _dio;
}
