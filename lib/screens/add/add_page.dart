import 'package:dev_hampter/components/buttons.dart';
import 'package:dev_hampter/utils/colors.dart';
import 'package:dev_hampter/utils/sizes.dart';
import 'package:dev_hampter/utils/uni_vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool type = false;
  final _dateController = TextEditingController();
  final _amountController = TextEditingController();

  void _toggleButtonA() {
    setState(() {
      type = false;
    });
  }

  void _toggleButtonB() {
    setState(() {
      type = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Container(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * .1,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: padding,
                height: height * .7,
                width: width,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ButtonToggleExample(
                        type: type,
                        toggleButtonA: _toggleButtonA,
                        toggleButtonB: _toggleButtonB,
                      ),
                      SizedBox(
                        height: height * .05,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: textColor,
                        ),
                        child: Row(
                          children: [
                            Text(
                              symbol,
                              style: TextStyle(
                                fontFamily: 'BalooThambi2',
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                            SizedBox(
                              width: width * .6,
                              child: TextField(
                                controller: _amountController,
                                cursorColor: whiteColor,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: TextStyle(
                                  fontFamily: 'BalooThambi2',
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(''),
                      TextField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          labelText: 'DATE',
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_today),
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectDate();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.dark(
                  primary: primaryColor, // header background color
                  onPrimary: whiteColor, // header text color
                  onSurface: textColor, // body text color
                  onSecondary: textColor,
                  surface: secondaryColor,
                  secondary: textColor),
              dialogBackgroundColor: Colors.white,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    color: primaryColor,
                    fontFamily: 'BalooThambi2',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  foregroundColor: primaryColor, // button text color
                ),
              ),
            ),
            child: child!);
      },
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
