import 'package:flutter/material.dart';
int monthlyBudget = 800000; 
int remainingBudget = monthlyBudget; 
double budget = remainingBudget / 100; 
String locale = 'id_ID';
String symbol = "Rp. ";
double budgetAmount = 1000;

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
    1,
  ),
  bonus(
    'Bonus',
    Icons.local_mall_outlined,
    2,
  );

  final String label;
  final IconData icon;
  final int id;

  const CategoryIncome(this.label, this.icon, this.id);
}
