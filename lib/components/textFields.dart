import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String _textDisplay;
  final double _height;
  final double? _width;
  final double _textSize;
  final EdgeInsetsGeometry _padding;
  final TextEditingController? _textController;
  final Color _textColor;
  final Color _borderColor;
  final Color _backgroundColor;
  final bool _isPassword;

  const CustomTextField({
    super.key,
    required String text,
    required double fontSize,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
    double? width,
    double height = 44,
    bool isPassword = false,
    TextEditingController? controller,
    Color borderColor = const Color(0xFFE0AC00),
    Color backgroundColor = Colors.white,
    Color textColor = const Color(0xFFF9DC5C),
  })  : _isPassword = isPassword,
        _backgroundColor = backgroundColor,
        _borderColor = borderColor,
        _textColor = textColor,
        _textController = controller,
        _padding = padding,
        _textSize = fontSize,
        _width = width,
        _height = height,
        _textDisplay = text;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _textController;
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create a new one
    _textController = widget._textController ?? TextEditingController();
  }

  @override
  void dispose() {
    // Dispose the controller only if it was created internally
    if (widget._textController == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget._width,
        height: widget._height,
        child: TextField(
          controller: _textController,
          cursorColor: widget._textColor,
          obscureText: widget._isPassword ? _isObscured : false,
          style: TextStyle(
            color: widget._textColor,
            fontFamily: 'BalooThambi2',
            fontSize: widget._textSize,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            hintText: widget._textDisplay,
            filled: true,
            fillColor: widget._backgroundColor,
            contentPadding: widget._padding,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget._borderColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget._borderColor, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintStyle: TextStyle(
              fontFamily: 'BalooThambi2',
              fontSize: widget._textSize,
              fontWeight: FontWeight.normal,
              color: widget._textColor,
            ),
            suffixIcon: widget._isPassword
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: widget._textColor,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          _isObscured = !_isObscured;
                        },
                      );
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
