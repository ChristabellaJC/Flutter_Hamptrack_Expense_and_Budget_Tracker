import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hampter/functions/chart/indicator.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/functions/data/firestore_service.dart';

//Categories
enum Categories {
  transportation(
    'Transportation',
    Icons.directions_bus_filled_outlined,
    1,
    Color.fromARGB(255, 231, 41, 196),
  ),
  foodanddrinks(
    'Food and Drinks',
    Icons.fastfood,
    2,
    Color(0xFF086788),
  ),
  essentials(
    'Essentials',
    Icons.favorite,
    3,
    Color(0xFF25CBE5),
  ),
  hygiene(
    'Hygiene',
    Icons.health_and_safety_outlined,
    4,
    Color(0xFFEF476F),
  ),
  hobbies(
    'Hobbies',
    Icons.sports_esports_outlined,
    5,
    Color.fromARGB(255, 255, 133, 62),
  ),
  salary(
    'Salary',
    Icons.payments_outlined,
    6,
    Color(0xFF06D6A0),
  ),
  bonus(
    'Bonus',
    Icons.local_mall_outlined,
    7,
    Color(0xFFFFD166),
  );

  const Categories(this.label, this.icon, this.id, this.color);
  final String label;
  final IconData icon;
  final int id;
  final Color color;
}

class PieChartSample2 extends StatefulWidget {
  final String userId;
  final DateTime selectedDate;

  const PieChartSample2({
    super.key,
    required this.userId,
    required this.selectedDate,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return AspectRatio(
      aspectRatio: 0.87,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getDataStream(
                widget.userId, widget.selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  'Error fetching data',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(
                  'No data available',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ));
              }
              List<PieChartSectionData> sections =
                  _generateSections(snapshot.data!.docs);
              return AspectRatio(
                aspectRatio: 50,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: sections,
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Categories.values.map((category) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Indicator(
                  color: category.color,
                  text: category.label,
                  textColor: textColor,
                  isSquare: true,
                  size: 15,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateSections(
      List<QueryDocumentSnapshot> docs) {
    List<Categories> categories = Categories.values;
    Map<Categories, double> categoryTotals = {
      for (var category in categories) category: 0
    };
    double totalSum = 0;

    for (var doc in docs) {
      int categoryIndex = doc['Category'];
      Categories category = categories[categoryIndex - 1];
      int amount = doc['Amount'];

      categoryTotals[category] = categoryTotals[category]! + amount;
      totalSum += amount;
    }

    List<PieChartSectionData> sections = [];
    categoryTotals.forEach((category, total) {
      double percentage = (total / totalSum) * 100;
      sections.add(
        PieChartSectionData(
          color: category.color,
          value: percentage,
          title: '${percentage.toStringAsFixed(1)}%',
          radius: touchedIndex == category.id ? 60.0 : 50.0,
          titleStyle: TextStyle(
            fontSize: touchedIndex == category.id ? 25.0 : 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'BalooThambi2',
            color: whiteColor,
          ),
        ),
      );
    });
    return sections;
  }
}
