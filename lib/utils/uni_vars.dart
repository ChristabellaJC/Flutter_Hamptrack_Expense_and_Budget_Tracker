import 'package:flutter/material.dart';

//Universal variables
//Money variables
String locale = 'id_ID';
String symbol = "Rp. ";

//Enums for expense and income
enum CategoryExpense {
  transportation(
    'Transportation',
    Icons.directions_bus_filled_outlined,
    1,
  ),
  foodanddrinks(
    'Food and Drinks',
    Icons.fastfood,
    2,
  ),
  essentials(
    'Essentials',
    Icons.favorite,
    3,
  ),
  hygiene(
    'Hygiene',
    Icons.health_and_safety_outlined,
    4,
  ),
  hobbies(
    'Hobbies',
    Icons.sports_esports_outlined,
    5,
  );

  final String label;
  final IconData icon;
  final int id;

  const CategoryExpense(this.label, this.icon, this.id);
}

enum CategoryIncome {
  salary(
    'Salary',
    Icons.payments_outlined,
    6,
  ),
  bonus(
    'Bonus',
    Icons.local_mall_outlined,
    7,
  );

  final String label;
  final IconData icon;
  final int id;

  const CategoryIncome(this.label, this.icon, this.id);
}
