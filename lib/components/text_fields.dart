import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:flutter/material.dart';

//Basic textfield
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
    //Default controller
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

//Empty textfield
class CustomTextFieldEmpty extends StatefulWidget {
  final TextEditingController? textController;
  final VoidCallback? onTap;
  final IconData icon;
  final String text;
  final String hint;
  final TextInputType keyboard;

  const CustomTextFieldEmpty({
    super.key,
    this.textController,
    this.onTap,
    required this.icon,
    required this.text,
    required this.hint,
    this.keyboard = TextInputType.text,
  });

  @override
  State<CustomTextFieldEmpty> createState() => _CustomTextFieldEmptyState();
}

class _CustomTextFieldEmptyState extends State<CustomTextFieldEmpty> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              widget.icon,
              color: iconColor,
              size: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'BalooThambi2',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
        TextField(
          controller: widget.textController,
          keyboardType: widget.keyboard,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontFamily: 'BalooThambi2',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: iconColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: iconColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          style: TextStyle(
            fontFamily: 'BalooThambi2',
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: textColor,
          ),
          readOnly: widget.onTap != null,
          onTap: widget.onTap,
        )
      ],
    );
  }
}

//Dropdown textfield
class DropDownFieldCustom extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool type;
  final double width;
  final TextEditingController categoryController;

  const DropDownFieldCustom({
    super.key,
    required this.categoryController,
    required this.type,
    required this.text,
    required this.icon,
    required this.width,
  });

  @override
  DropDownFieldCustomState createState() => DropDownFieldCustomState();
}

class DropDownFieldCustomState extends State<DropDownFieldCustom> {
  late List<dynamic> dropdownMenuEntries;
  dynamic selectedCategory;

  @override
  void initState() {
    super.initState();
    dropdownMenuEntries =
        widget.type ? CategoryExpense.values : CategoryIncome.values;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              widget.icon,
              color: iconColor,
              size: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'BalooThambi2',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
        if (widget.type) ...[
          DropDownExpense(
            categoryController: widget.categoryController,
            width: widget.width,
            onChanged: (value) => setState(() => selectedCategory = value),
          )
        ] else ...[
          DropDownIncome(
            categoryController: widget.categoryController,
            width: widget.width,
            onChanged: (value) => setState(() => selectedCategory = value),
          )
        ]
      ],
    );
  }

  int? getSelectedCategoryId() {
    if (selectedCategory == null) return null;
    return selectedCategory.id;
  }
}

class DropDownExpense extends StatefulWidget {
  final TextEditingController categoryController;
  final double width;
  final Function(CategoryExpense) onChanged;

  const DropDownExpense({
    super.key,
    required this.categoryController,
    required this.width,
    required this.onChanged,
  });

  @override
  State<DropDownExpense> createState() => _DropDownExpenseState();
}

//Dropdown for expense
class _DropDownExpenseState extends State<DropDownExpense> {
  CategoryExpense? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryExpense>(
      iconEnabledColor: iconColor,
      iconDisabledColor: iconColor,
      value: selectedCategory,
      onChanged: (CategoryExpense? newValue) {
        setState(() {
          selectedCategory = newValue!;
          widget.categoryController.text = newValue.label;
          widget.onChanged(newValue);
        });
      },
      items: CategoryExpense.values.map<DropdownMenuItem<CategoryExpense>>(
        (CategoryExpense category) {
          return DropdownMenuItem<CategoryExpense>(
            value: category,
            child: Row(
              children: [
                Icon(category.icon, color: iconColor),
                const SizedBox(width: 10),
                Text(category.label, style: TextStyle(color: textColor)),
              ],
            ),
          );
        },
      ).toList(),
      decoration: InputDecoration(
        iconColor: iconColor,
        suffixIconColor: iconColor,
        hintText: 'Pick a Category',
        hintStyle: TextStyle(
          fontFamily: 'BalooThambi2',
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: textColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: iconColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: iconColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: iconColor,
            width: 1,
          ),
        ),
      ),
      style: TextStyle(
        fontFamily: 'BalooThambi2',
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      dropdownColor: secondaryColor,
    );
  }
}

//Dropdown for income
class DropDownIncome extends StatefulWidget {
  final TextEditingController categoryController;
  final double width;
  final Function(CategoryIncome) onChanged;

  const DropDownIncome({
    super.key,
    required this.categoryController,
    required this.width,
    required this.onChanged,
  });

  @override
  State<DropDownIncome> createState() => _DropDownIncomeState();
}

class _DropDownIncomeState extends State<DropDownIncome> {
  CategoryIncome? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryIncome>(
      iconEnabledColor: iconColor,
      iconDisabledColor: iconColor,
      value: selectedCategory,
      onChanged: (CategoryIncome? newValue) {
        setState(() {
          selectedCategory = newValue!;
          widget.categoryController.text = newValue.label;
          widget.onChanged(newValue);
        });
      },
      items: CategoryIncome.values.map<DropdownMenuItem<CategoryIncome>>(
        (CategoryIncome category) {
          return DropdownMenuItem<CategoryIncome>(
            value: category,
            child: Row(
              children: [
                Icon(category.icon, color: iconColor),
                const SizedBox(width: 10),
                Text(category.label, style: TextStyle(color: textColor)),
              ],
            ),
          );
        },
      ).toList(),
      decoration: InputDecoration(
        iconColor: iconColor,
        suffixIconColor: iconColor,
        hintText: 'Pick a Category',
        hintStyle: TextStyle(
          fontFamily: 'BalooThambi2',
          fontSize: 20,
          fontWeight: FontWeight.normal,
          color: textColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: iconColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: iconColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: iconColor,
            width: 1,
          ),
        ),
      ),
      style: TextStyle(
        fontFamily: 'BalooThambi2',
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      dropdownColor: secondaryColor,
    );
  }
}
