import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final BorderRadiusGeometry _borderRadius;
  final double? _width;
  final double _height;
  final Gradient _gradient;
  final VoidCallback? _onPressed;
  final String _enabledText;

  const CustomButton({
    super.key,
    required String enabledText,
    required void Function()? onPressed,
    required BorderRadiusGeometry borderRadius,
    double? width,
    double height = 44.0,
    Gradient gradient = const LinearGradient(
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
  })  : _enabledText = enabledText,
        _onPressed = onPressed,
        _gradient = gradient,
        _height = height,
        _width = width,
        _borderRadius = borderRadius;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: widget._width,
            height: widget._height,
            decoration: BoxDecoration(
              gradient: widget._gradient,
              borderRadius: widget._borderRadius,
            ),
            child: ElevatedButton(
              onPressed: widget._onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape:
                    RoundedRectangleBorder(borderRadius: widget._borderRadius),
              ),
              child: Text(
                widget._enabledText,
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
