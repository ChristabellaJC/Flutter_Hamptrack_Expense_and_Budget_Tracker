import 'package:flutter/material.dart';

//Custom Checkbox
class CustomCheckBox extends StatefulWidget {
  final double scaleSize;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckBox({
    super.key,
    this.scaleSize = 1.0,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  final Color _borderColor = const Color(0xFFE0AC00);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scaleSize,
      child: Checkbox(
        value: widget.value,
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
        onChanged: widget.onChanged,
      ),
    );
  }
}
