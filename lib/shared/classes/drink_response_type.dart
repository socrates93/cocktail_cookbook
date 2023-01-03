import 'dart:convert';

import 'package:cocktail_cookbook/shared/classes/drink.dart';

DrinkResponseType drinkFromJson(String str) =>
    DrinkResponseType.fromJson(json.decode(str));

String drinkToJson(DrinkResponseType data) => json.encode(data.toJson());

class DrinkResponseType {
  DrinkResponseType({
    this.drinks,
  });

  List<Drink>? drinks;

  factory DrinkResponseType.fromJson(Map<String, dynamic> json) =>
      DrinkResponseType(
        drinks: json["drinks"] == null
            ? null
            : List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "drinks": drinks == null
            ? null
            : List<dynamic>.from(drinks!.map((x) => x.toJson())),
      };
}
