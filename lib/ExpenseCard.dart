import 'package:flutter/material.dart';

class CardsEntry extends StatelessWidget {
  final String itemName;
  final int price;
  final DateTime date;
  final Function() deleteFunction;
  const CardsEntry(
      {Key? key,
      required this.itemName,
      required this.price,
      required this.date, required this.deleteFunction})
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
                  Text(itemName),
                  Text("${date.day}-${date.month}-${date.year}"),
                ],
              ),
              IconButton(
                onPressed: deleteFunction,
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

// import 'package:flutter/material.dart';

// class ExpenseCard extends StatelessWidget {
//   final String item;
//   final int price;
//   final DateTime date;

//   const ExpenseCard(
//       {Key? key, required this.item, required this.price, required this.date})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.purple,
//               radius: 35,
//               child: Text(price.toString()),
//             ),
//             title: Text(item),
//             subtitle: Text(
//               date.toString(),
//               style: TextStyle(color: Colors.black.withOpacity(0.6)),
//             ),
//             trailing: IconButton(
//               // onPressed: widget.deleteFunction,
//               onPressed: () {},
//               icon: const Icon(Icons.delete),
//               color: Colors.red,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }