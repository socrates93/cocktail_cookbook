import 'package:cocktail_cookbook/shared/classes/drink.dart';

import 'drink_repository.dart';

class DrinkService {
  final DrinkRepository drinkRepository = DrinkRepository();

  DrinkService();

  Future<List<Drink>> getDrinks() async {
    final result = await drinkRepository.getDrinks();

    if (result == null) return [];

    return result;
  }

  // Future<Drink> getDrink(int id) async {
  //   return await drinkRepository.getDrink(id);
  // }

  // Future<Drink> createDrink(Drink drink) async {
  //   return await drinkRepository.createDrink(drink);
  // }

  // Future<Drink> updateDrink(Drink drink) async {
  //   return await drinkRepository.updateDrink(drink);
  // }

  // Future<void> deleteDrink(int id) async {
  //   await drinkRepository.deleteDrink(id);
  // }
}
