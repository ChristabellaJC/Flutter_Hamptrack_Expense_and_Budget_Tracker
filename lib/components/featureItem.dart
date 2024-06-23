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
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 5),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.black54),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
