import 'package:cocktail_cookbook/shared/classes/drink.dart';
import 'package:cocktail_cookbook/shared/classes/drink_response_type.dart';
import 'drink_repository.dart';

class DrinkService {
  final DrinkRepository drinkRepository = DrinkRepository();

  Future<List<Drink>> getById(int id) async {
    final result =
        await drinkRepository.get<Map<String, dynamic>>("/lookup.php?i=$id");

    if (result == null) return [];

    return DrinkResponseType.fromJson(result).drinks ?? [];
  }

  Future<List<Drink>> getFiltered(String by, {String identifier = 'a'}) async {
    final result = await drinkRepository
        .get<Map<String, dynamic>>("/filter.php?$identifier=$by");

    if (result == null) return [];

    return DrinkResponseType.fromJson(result).drinks ?? [];
  }

  Future<List<Drink>> getCategories() async {
    final result =
        await drinkRepository.get<Map<String, dynamic>>("/list.php?c=list");

    if (result == null) return [];

    return DrinkResponseType.fromJson(result).drinks ?? [];
  }
}
