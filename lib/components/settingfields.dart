import 'package:flutter/material.dart';
import 'package:dev_hampter/utils/colors.dart';

class SettingFields extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isObscured;

  const SettingFields({
    super.key,
    required this.label,
    required this.controller,
    this.isObscured = false,
  });

  @override
  State<SettingFields> createState() => _SettingFieldsState();
}

class _SettingFieldsState extends State<SettingFields> {
  late TextEditingController _textController;
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _textController = widget.controller;
    _isObscured = widget.isObscured;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            fontFamily: 'BalooThambi2',
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _textController,
          style: TextStyle(
            color: textColor,
            fontFamily: 'BalooThambi2',
          ),
          obscureText: _isObscured,
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: TextStyle(
              color: secTextColor,
              fontFamily: 'BalooThambi2'
            ),
            filled: true,
            fillColor: whiteColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            
            suffixIcon: widget.isObscured
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                      color: secTextColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
