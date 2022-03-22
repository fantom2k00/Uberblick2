import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Food {
  int serving, quantity, calories;
  double kgCo2Eq, landUse, waterUse, carbs, fat, protein, price;
  String food, unit, nutriscore, ingredients, ecoRating, producer, distributor, additionalInfo;

  Food({
    this.food,
    this.price,

    this.unit,
    this.serving,
    this.quantity,

    this.kgCo2Eq,
    this.landUse,
    this.waterUse,
    this.ecoRating,

    this.nutriscore,
    this.calories,
    this.carbs,
    this.fat,
    this.protein,
    this.ingredients,

    this.producer,
    this.distributor,
    this.additionalInfo,
  });

  Map<String, dynamic> getFood() {
    final map = <String, dynamic>{};

    map['food'] = food;
    map['price'] = price;

    map['unit'] = unit;
    map['serving'] = serving;
    map['quantity'] = quantity;

    map['kg_co2_eq'] = kgCo2Eq;
    map['land_use'] = landUse;
    map['water_use'] = waterUse;
    map['eco_rating'] = ecoRating;

    map['nutriscore'] = nutriscore;
    map['calories'] = calories;
    map['carbs'] = carbs;
    map['fat'] = fat;
    map['protein'] = protein;
    map['ingredients'] = ingredients;

    map['producer'] = producer;
    map['distributor'] = distributor;
    map['additional_info'] = additionalInfo;

    return map;
  }
}