import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';

//Custom box
class Box extends StatefulWidget {
  final String _title;
  final int _value;

  const Box({super.key, required String title, required int value})
      : _title = title,
        _value = value;

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget._title,
          style: TextStyle(
            color: textColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rp',
              style: TextStyle(color: whiteColor),
            ),
            Text(
              widget._value.toString(),
              style: TextStyle(color: whiteColor),
            ),
          ],
        )
      ],
    );
  }
}
