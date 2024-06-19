import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_hampter/components/textFields.dart';
import 'package:dev_hampter/functions/data/firestore_service.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomBlock extends StatefulWidget {
  final int _category;
  final DateTime _date;
  final int _amount;
  final bool _type;
  final String _note;
  final String docId;
  final String userID; // Accept userID as a parameter
  final Function(String) onDelete;

  const CustomBlock({
    super.key,
    required int category,
    required String userId,
    required String note,
    required int amount,
    required bool type,
    required DateTime date,
    required this.docId,
    required this.onDelete,
  })  : _amount = amount,
        _type = type,
        _date = date,
        _note = note,
        _category = category,
        userID = userId;

  @override
  State<CustomBlock> createState() => _CustomBlockState();
}

class _CustomBlockState extends State<CustomBlock> {
  Color _color() {
    return widget._type ? redCol : greenCol;
  }

  IconData _icon() {
    return widget._type ? Icons.payments : Icons.savings;
  }

  String _formattedDate() {
    return DateFormat('dd/MM/yyyy').format(widget._date);
  }

  void _showDetailsDialog() {
    String _formattedamount = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: 0,
    ).format(widget._amount);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: secondaryColor,
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            constraints: BoxConstraints(maxHeight: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: iconColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Details',
                      style: TextStyle(
                        color: textColor,
                        fontFamily: 'BalooThambi2',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.edit, color: iconColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showEditDialog(
                            context,
                            widget.docId,
                            widget.userID,
                            widget._date,
                            widget._amount,
                            widget._type,
                            widget._note,
                            widget._category); // Show edit dialog
                      },
                    ),
                  ],
                ),
                // Divider(color: whiteColor),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount',
                            style: TextStyle(
                              color: textColor,
                              fontFamily: 'BalooThambi2',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _formattedamount,
                            style: TextStyle(
                              color: textColor,
                              fontFamily: 'BalooThambi2',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Date',
                            style: TextStyle(
                              color: textColor,
                              fontFamily: 'BalooThambi2',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _formattedDate(),
                            style: TextStyle(
                              color: textColor,
                              fontFamily: 'BalooThambi2',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Note',
                            style: TextStyle(
                              color: textColor,
                              fontFamily: 'BalooThambi2',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget._note,
                            style: TextStyle(
                              color: textColor,
                              fontFamily: 'BalooThambi2',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _formattedamount = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: 0,
    ).format(widget._amount);

    return GestureDetector(
      onTap: _showDetailsDialog,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          color: _color(),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color: secondaryColor,
              ),
              child: Icon(
                _icon(),
                color: _color(),
                size: 20,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formattedamount.toString(),
                        style: TextStyle(
                          fontFamily: 'BalooThambi2',
                          color: whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formattedDate(),
                        style: TextStyle(
                          fontFamily: 'BalooThambi2',
                          color: whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => widget
                        .onDelete(widget.docId), // Call onDelete with docId
                    icon: Icon(
                      Icons.delete,
                      size: 30, // Adjust size as needed
                      color: whiteColor, // Adjust color as needed
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showEditDialog(
      BuildContext context,
      String docId,
      String userID,
      DateTime initialDate,
      int initialAmount,
      bool initialType,
      String initialNote,
      int initialCategory) async {
    final _dateController = TextEditingController(
        text: DateFormat('yyyy/MM/dd').format(initialDate));
    final _amountController =
        TextEditingController(text: initialAmount.toString());
    final _noteController = TextEditingController(text: initialNote);
    final _categoryController =
        TextEditingController(text: initialCategory.toString());
    bool _type = initialType;

    void _toggleType(bool type) {
      _type = type;
    }

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: secondaryColor,
          contentPadding: EdgeInsets.all(10.0),
          content: Container(
            width: double.maxFinite,
            // constraints: BoxConstraints(maxHeight: 800),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: iconColor),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: textColor,
                          fontFamily: 'BalooThambi2',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.save, color: iconColor),
                        onPressed: () async {
                          int amount =
                              int.tryParse(_amountController.text) ?? 0;
                          DateTime date =
                              DateTime.tryParse(_dateController.text) ??
                                  DateTime.now();
                          String note = _noteController.text;
                          int category =
                              int.tryParse(_categoryController.text) ?? 0;

                          await FirestoreService().updateData(
                            docId,
                            userID,
                            note,
                            date,
                            _type,
                            amount,
                            category,
                          );

                          Navigator.of(context).pop();
                        },
                      ),
                    ]),
                CustomTextFieldEmpty(
                  icon: Icons.dataset_outlined,
                  text: 'Amount',
                  hint: 'Amount here...',
                  textController: _amountController,
                ),
                CustomTextFieldEmpty(
                  icon: Icons.calendar_today_outlined,
                  text: 'Date',
                  hint: 'YYYY/MM/DD',
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.dark(
                              primary: primaryColor,
                              onPrimary: whiteColor,
                              onSurface: textColor,
                              onSecondary: textColor,
                              surface: secondaryColor,
                              secondary: textColor,
                            ),
                            dialogBackgroundColor: whiteColor,
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                  color: primaryColor,
                                  fontFamily: 'BalooThambi2',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                                foregroundColor: primaryColor,
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (picked != null) {
                      _dateController.text = picked.toString().split(" ")[0];
                    }
                  },
                  textController: _dateController,
                ),
                SizedBox(height: 10),
                CustomTextFieldEmpty(
                  icon: Icons.note_alt_outlined,
                  text: 'Note',
                  hint: 'Notes...',
                  textController: _noteController,
                ),
                SizedBox(height: 10),
                CustomTextFieldEmpty(
                  icon: Icons.category_outlined,
                  text: 'Category',
                  hint: 'Category here...',
                  textController: _categoryController,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
