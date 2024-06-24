import 'package:flutter/material.dart';
import 'package:dev_hampter/utils/colors.dart';

class FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  const FeatureItem({
    super.key,
    required this.title,
    required this.description,
  });

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
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
