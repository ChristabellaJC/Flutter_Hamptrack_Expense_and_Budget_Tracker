import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';

//Horizontal Calendar
class HorizontalCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const HorizontalCalendar({super.key, required this.onDateSelected});

  @override
  // ignore: library_private_types_in_public_api
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime selectedDate = DateTime.now();

  List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: .2),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: months.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = DateTime(selectedDate.year, index + 1);
                    widget.onDateSelected(selectedDate);
                  });
                },
                child: Container(
                  width: 100,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: selectedDate.month == index + 1
                        ? toolbarIconColor
                        : primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    months[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'BalooThambi2',
                      fontWeight: FontWeight.normal,
                      color: selectedDate.month == index + 1
                          ? Colors.white
                          : Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_left,
                color: textColor,
              ),
              onPressed: () {
                setState(
                  () {
                    selectedDate = DateTime(
                      selectedDate.year - 1,
                      selectedDate.month,
                    );
                    widget.onDateSelected(selectedDate);
                  },
                );
              },
            ),
            Text(
              '${selectedDate.year}',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'BalooThambi2',
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_right,
                color: textColor,
              ),
              onPressed: () {
                setState(
                  () {
                    selectedDate = DateTime(
                      selectedDate.year + 1,
                      selectedDate.month,
                    );
                    widget.onDateSelected(selectedDate);
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
