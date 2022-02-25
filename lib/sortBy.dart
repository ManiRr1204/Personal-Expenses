import 'package:flutter/material.dart';
import 'package:reminder_app/ExpenseCard.dart';
import './ExpenseCard.dart';

class SortBy extends StatefulWidget {
  final Map<String, Map<String, dynamic>> expense;
  final String sortby;
  //final Map<DateTime, List<String>> sortbyDate;
  const SortBy({
    Key? key,
    required this.expense,
    required this.sortby,
  }) : super(key: key);

  @override
  State<SortBy> createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  List<String> sortByMethod() {
    if (widget.sortby == 'Entry') {
      return widget.expense.keys.toList();
    } else if (widget.sortby == 'ItemName') {
      return widget.expense.keys.toList()..sort();
    } else {
      return widget.expense.keys.toList()
        ..sort((k1, k2) =>
            ((widget.expense[k1]!)[widget.sortby]).compareTo((widget.expense[k2]!)[widget.sortby]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...(sortByMethod()).map((String mapkey) {
          return CardsEntry(
            itemName: mapkey,
            //price: int.parse((widget.expense[mapkey]!)['price']),
            price: (widget.expense[mapkey]!)['price'],
            date: (widget.expense[mapkey]!)['date'],
            deleteFunction: () {
              setState(() {
                widget.expense.remove(mapkey);
              });
            },
          );
        }),
      ],
    );
  }
}
