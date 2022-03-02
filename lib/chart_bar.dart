import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingTotalAmountPer;

  const ChartBar(this.label,this.spendingAmount,this.spendingTotalAmountPer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 20 ,child: FittedBox(child: Text('\u20B9${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(height:4,),
        Container(
          height: 50,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                color: Color.fromARGB(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),  
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingTotalAmountPer,
              child: Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor)),
            )
          ]),
        ),
        SizedBox(height: 4,),
        Text(label),
      ],
    );
  }
}
