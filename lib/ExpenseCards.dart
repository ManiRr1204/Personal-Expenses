import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final String itemName;
  final String price;
  final DateTime date;

  const ExpenseCard(
      {Key? key, required this.itemName, required this.price, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              radius: 35,
              child: Text(price.toString()),
            ),
            title: Text(itemName),
            subtitle: Text(
              date.toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: IconButton(
              // onPressed: widget.deleteFunction,
              onPressed: () {},
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}