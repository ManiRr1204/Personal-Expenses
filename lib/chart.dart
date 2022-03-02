import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final Map<String, Map<String, dynamic>> expense;
  Chart(this.expense, {Key? key}) : super(key: key);

  List<Map<String, dynamic>> get groupedTransactionAmount {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.00;

      expense.keys.forEach((i) {
        if (expense[i]!['date'].day == weekDay.day &&
            expense[i]!['date'].month == weekDay.month &&
            expense[i]!['date'].year == weekDay.year) {
          totalSum += expense[i]!['price'];
        }
      });
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'price': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionAmount.fold(0.0, (sum, itemName) {
      return sum + itemName['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionAmount.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'].toString(),
                    data['price'],
                    totalSpending == 0.0
                        ? 0.0
                        : (data['price'] as double) / totalSpending));
          }).toList(),
        ),
      ),
    );
  }
}
