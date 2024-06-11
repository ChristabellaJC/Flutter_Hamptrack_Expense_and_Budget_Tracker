import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';

class ElevatedButtonExample extends StatefulWidget {
  final BorderRadiusGeometry borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final String enabledText;

  const ElevatedButtonExample({
    Key? key,
    required this.enabledText,
    required this.onPressed,
    required this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0.2,
          0.8,
        ],
        colors: [
          Color(0xFFFAE588),
          Color(0xFFF9DC5C)
        ]),
  }) : super(key: key);

  @override
  State<ElevatedButtonExample> createState() => _ElevatedButtonExampleState();
}

class _ElevatedButtonExampleState extends State<ElevatedButtonExample> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: widget.borderRadius,
            ),
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape:
                    RoundedRectangleBorder(borderRadius: widget.borderRadius),
              ),
              child: Text(
                widget.enabledText,
                style: TextStyle(
                  fontFamily: 'BalooThambi2',
                  fontSize: 25,
                  color: whiteColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
