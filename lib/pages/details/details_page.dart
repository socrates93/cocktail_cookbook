import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/shared/classes/drink.dart';

class DetailsPageWidget extends StatefulWidget {
  const DetailsPageWidget({super.key});

  @override
  State<DetailsPageWidget> createState() => _DetailsPageWidgetState();
}

class _DetailsPageWidgetState extends State<DetailsPageWidget> {
  List<String> _getIngredientList(Drink drink) {
    final ingredients = <String>[];
    final jsonDrink = drink.toJson();

    for (var i = 1; i <= 15; i++) {
      final ingredient = jsonDrink['strIngredient$i'];
      final measure = jsonDrink['strMeasure$i'];

      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add('$ingredient - $measure');
      }
    }

    return ingredients;
  }

  @override
  Widget build(BuildContext context) {
    Drink drink = ModalRoute.of(context)!.settings.arguments as Drink;
    drink.ingredients = _getIngredientList(drink);

    final device = MediaQuery.of(context);

    return Hero(
      tag: 'drink-${drink.idDrink}',
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF875B9F),
                Color(0xFF391052),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: SizedBox(
                  width: device.size.width,
                  height: device.size.height * 0.5,
                  child: Image.network(
                    drink.strDrinkThumb!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: BackButton(
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: device.size.height * 0.5 - 50,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: device.size.height * 0.56,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drink.strDrink ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        drink.strInstructions ?? "No Instructions",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      if (drink.ingredients != null &&
                          drink.ingredients!.isNotEmpty)
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                "Ingredients",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                flex: 1,
                                child: ListView.builder(
                                  itemCount: drink.ingredients!.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: device.size.width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            drink.ingredients![index]!
                                                .split('-')[0],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            drink.ingredients![index]!
                                                .split('-')[1],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
