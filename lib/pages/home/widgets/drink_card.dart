import 'package:flutter/material.dart';

import 'package:cocktail_cookbook/shared/classes/drink.dart';

class DrinkCardWidget extends StatelessWidget {
  final double width;
  final double height;
  final Drink drink;

  const DrinkCardWidget({
    super.key,
    required this.drink,
    this.width = double.maxFinite,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          print(drink.toJson());
        },
        child: SizedBox(
          width: width,
          height: height,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Image.network(
                    drink.strDrinkThumb!,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext _, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;

                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          drink.strDrink ?? "Unknown Drink",
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          drink.strInstructions ?? "No instructions",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
