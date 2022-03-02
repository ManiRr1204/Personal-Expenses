import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardsEntry extends StatelessWidget {
  final String itemName;
  final int price;
  final DateTime date;
  final Function() deleteFunction;
  Widget _deleteDialogBox(BuildContext context) {
    return AlertDialog(
      //title: const Text('Are you sure to delete?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Are You want to delete?'),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              deleteFunction();
              Navigator.pop(context);
            },
            child: const Text('Yes',),
            //style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
            ),
            
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'))
      ],
    );
  }

  const CardsEntry(
      {Key? key,
      required this.itemName,
      required this.price,
      required this.date,
      required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Text(transaction['Shoes']!['price'] as String),
              CircleAvatar(
                child: Text('\u20B9 $price'),
                radius: 30,
              ),
              Column(
                children: [
                  Text(itemName, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text(DateFormat.yMd().format(date)),
                ],
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                        _deleteDialogBox(context));
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
