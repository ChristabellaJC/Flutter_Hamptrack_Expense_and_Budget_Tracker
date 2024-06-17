import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final double _scaleSize;

  const CustomCheckBox({
    super.key,
    double scaleSize = 1.0,
  }) : _scaleSize = scaleSize;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _termsChecked = false;
  Color _borderColor = Color(0xFFE0AC00);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget._scaleSize,
      child: Checkbox(
        value: _termsChecked,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(
            width: 1.0,
            color: _borderColor,
          ),
        ),
        activeColor: _borderColor,
        onChanged: (value) {
          setState(() {
            _termsChecked = !_termsChecked;
          });
        },
      ),
    );
  }
}
