import 'package:flutter/material.dart';
import 'package:dev_hampter/utils/colors.dart';

class FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  const FeatureItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontFamily: 'BalooThambi2',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: TextStyle(
            color: textColor,
            fontFamily: 'BalooThambi2',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
