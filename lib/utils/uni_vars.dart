// String username = 'Angela Chow';
import 'package:flutter/material.dart';

double incomeAmt = 100000;
double expenseAmt = 100000;
double budgetProg = 0;
String mouCons = 'Doing Well';
// bool type = false;
String locale = 'id_ID';
String symbol = "Rp. ";

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

  const CategoryExpense(this.label, this.icon, this.id);
  final String label;
  final IconData icon;
  final int id;
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

  const CategoryIncome(this.label, this.icon, this.id);
  final String label;
  final IconData icon;
  final int id;
}
