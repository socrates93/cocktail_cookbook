import 'package:flutter/foundation.dart';

import 'package:cocktail_cookbook/repository/config.dart';

class DrinkRepository {
  final DioClient dioClient = DioClient();

  Future<Map<String, dynamic>?> get<T>(String path) async {
    try {
      final result = await dioClient.instance.get<T>(path);

      if (result.data != null) {
        return result.data as Map<String, dynamic>;
      }

      return Future.value(null);
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }

      throw Exception(e);
    }
  }
}
