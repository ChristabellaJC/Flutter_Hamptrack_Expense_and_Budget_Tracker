import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:flutter/material.dart';

class MouState extends StatefulWidget {
  @override
  _MouStateState createState() => _MouStateState();
}

class _MouStateState extends State<MouState> {
  late String mouCondition;

  @override
  void initState() {
    super.initState();
    updateMouCondition(
        budgetProg); // Initialize mouCondition based on initial budgetProg
  }

  void updateMouCondition(double value) {
    if (value >= 0.7 && value <= 1) {
      mouCondition = 'Feeling Happy!';
    } else if (value >= 0.4 && value < 0.7) {
      mouCondition = 'Doing Well!';
    } else if (value >= 0.1 && value < 0.4) {
      mouCondition = 'A bit concerned...';
    } else if (value == 0) {
      mouCondition = 'Dead';
    } else {
      mouCondition = 'Invalid value';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getImageForValue(budgetProg),
        SizedBox(height: 10),
        Text(
          mouCondition,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget getImageForValue(double value) {
    if (value >= 0.7 && value <= 1) {
      return Image.asset('assets/mous/mouA.png');
    } else if (value >= 0.4 && value < 0.7) {
      return Image.asset('assets/mous/mouB.png');
    } else if (value >= 0.1 && value < 0.4) {
      return Image.asset('assets/mous/mouC.png');
    } else if (value == 0) {
      return Image.asset('assets/mous/mouD.png');
    } else {
      return Text('Invalid value');
    }
  }
}
