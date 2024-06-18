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

class CustomTextButton extends StatefulWidget {
  final VoidCallback? _onPressed;
  final String _text;
  final double _textSize;
  final Color _textColor;
  final FontWeight? _textWeight;

  const CustomTextButton({
    super.key,
    required void Function()? onPressed,
    required String text,
    required Color textColor,
    FontWeight textWeight = FontWeight.w700,
    double textSize = 18,
  })  : _onPressed = onPressed,
        _text = text,
        _textSize = textSize,
        _textColor = textColor,
        _textWeight = textWeight;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget._onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
      ),
      child: Text(
        widget._text,
        style: TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: widget._textColor,
            fontFamily: 'BalooThambi2',
            fontSize: widget._textSize,
            color: widget._textColor,
            fontWeight: widget._textWeight),
      ),
    );
  }
}

class ButtonToggleExample extends StatefulWidget {
  final bool type;
  final VoidCallback toggleButtonA;
  final VoidCallback toggleButtonB;

  const ButtonToggleExample({
    Key? key,
    required this.type,
    required this.toggleButtonA,
    required this.toggleButtonB,
  }) : super(key: key);

  @override
  _ButtonToggleExampleState createState() => _ButtonToggleExampleState();
}

class _ButtonToggleExampleState extends State<ButtonToggleExample> {
  @override
  Widget build(BuildContext context) {
    Color buttonAColor = widget.type ? secondaryColor : primaryColor;
    Color buttonBColor = widget.type ? primaryColor : secondaryColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: widget.toggleButtonA,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonAColor,
            elevation: 0,
            fixedSize: Size(150, 50),
            side: BorderSide(color: primaryColor),
          ),
          child: Text(
            'Income',
            style: TextStyle(
              fontFamily: 'BalooThambi2',
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: widget.toggleButtonB,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBColor,
            elevation: 0,
            fixedSize: Size(150, 50),
            side: BorderSide(color: primaryColor),
          ),
          child: Text(
            'Expense',
            style: TextStyle(
              fontFamily: 'BalooThambi2',
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
