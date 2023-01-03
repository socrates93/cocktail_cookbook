import 'package:flutter/foundation.dart';

import 'package:cocktail_cookbook/repository/config.dart';
import 'package:cocktail_cookbook/shared/classes/drink.dart';
import 'package:cocktail_cookbook/shared/classes/drink_response_type.dart';

class DrinkRepository {
  final DioClient dioClient = DioClient();

  DrinkRepository();

  Future<List<Drink>?> getDrinks() async {
    try {
      final result = await dioClient.instance
          .get<Map<String, dynamic>>('/lookup.php?i=11007');

      if (kDebugMode) {
        print(result.data);
      }

      if (result.data != null) {
        final data = DrinkResponseType.fromJson(result.data!);

        if (data.drinks == null) return [];

        return data.drinks;
      }

      return [];
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }

      throw Exception(e);
    }
  }
}
