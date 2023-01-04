import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/shared/classes/drink.dart';

class DrinkCardWidget extends StatelessWidget {
  final double width;
  final double height;
  final Drink drink;
  final VoidCallback? onTap;

  const DrinkCardWidget({
    super.key,
    required this.drink,
    required this.onTap,
    this.width = double.maxFinite,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'drink-${drink.idDrink}',
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    drink.strDrinkThumb!,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      drink.strDrink ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
