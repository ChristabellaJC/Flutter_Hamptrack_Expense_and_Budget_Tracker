import 'package:dev_hampter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomBlock extends StatefulWidget {
  final DateTime _date;
  final int _amount;
  final bool _type;

  const CustomBlock({
    super.key,
    required int amount,
    required bool type,
    required DateTime date,
  })  : _amount = amount,
        _type = type,
        _date = date;

  @override
  State<CustomBlock> createState() => _CustomBlockState();
}

class _CustomBlockState extends State<CustomBlock> {
  Color _color() {
    return widget._type ? greenCol : redCol;
  }

  IconData _icon() {
    return widget._type ? Icons.savings : Icons.payments;
  }

  String _formattedDate() {
    return DateFormat('dd/MM/yyyy').format(widget._date);
  }

  @override
  Widget build(BuildContext context) {
    String _formattedamount = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(widget._amount);

    return Container(
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
                  onPressed: () {},
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
    );
  }
}
