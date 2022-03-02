import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart.dart';
import './sortBy.dart';

void main() {
  runApp(const PersonalExpenseApp());
}

class PersonalExpenseApp extends StatefulWidget {
  const PersonalExpenseApp({Key? key}) : super(key: key);

  @override
  _PersonalExpenseAppState createState() => _PersonalExpenseAppState();
}

enum SortByProperty { entry, date, price }

class _PersonalExpenseAppState extends State<PersonalExpenseApp> {
  bool _show = false;
  bool isDateChoosen = false;
  bool isTransactionAdded = false;
  dynamic _dateTime;
  bool btnshow = true;
  bool isItemNameValid = true;
  bool isAmountValid = true;
  bool isDateValid = true;
  bool isDubKey = false;

  // var expense = {
  //   'shoes': {'price': 100, 'date': DateTime(2022, 2, 19)},
  //   'shoes1': {'price': 90, 'date': DateTime(2022, 2, 13)},
  //   'shoes2': {'price': 110, 'date': DateTime(2022, 2, 14)},
  //   'shoes3': {'price': 170, 'date': DateTime(2022, 2, 19)},
  //   'shoes4': {'price': 400, 'date': DateTime(2022, 2, 12)},
  //   'shoes5': {'price': 230, 'date': DateTime(2022, 2, 12)},
  //   'shoes6': {'price': 340, 'date': DateTime(2022, 2, 13)},
  //   'shoes7': {'price': 10, 'date': DateTime(2022, 2, 21)},
  //   'shoes8': {'price': 100, 'date': DateTime(2022, 2, 9)},
  //   'shoes9': {'price': 1000, 'date': DateTime(2022, 2, 19)},
  // };
  Map<String, Map<String, dynamic>> expense = {};

  String initialValue = 'Entry';
  List<String> sortBylist = ['Entry', 'date', 'price', 'ItemName'];
  SortByProperty sortByProperty = SortByProperty.date;
  final TextEditingController _itemtitle = TextEditingController();
  final TextEditingController _itemamount = TextEditingController();

  bool validateAddTxnButton() {
    if (_itemamount.text.isNotEmpty &&
        _itemamount.text.isNotEmpty &&
        _dateTime != null) {
      return true;
    }
    return false;
  }

  bool validateClearButton() {
    if (_itemtitle.text.isEmpty ||
        _itemamount.text.isEmpty ||
        _dateTime == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses'),
          actions: [
            DropdownButton<String>(
                value: initialValue,
                items: sortBylist.map((items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items, style: TextStyle(color: Colors.white, fontSize: 18),),
                  );
                }).toList(),
                icon: const Icon(Icons.list),
                iconEnabledColor: Colors.white,
                dropdownColor: Colors.purple,
                onChanged: (value) {
                  setState(() {
                    initialValue = value!;
                  });
                }),
            IconButton(
                onPressed: () {
                  setState(() {
                    _show = true;
                    btnshow = false;
                  });

                  //Navigator.pop(context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: GestureDetector(
          onTap: () {
            setState(() {
              _show = false;
              btnshow = true;
            });
          },
          child: Column(
            children: [
              // const SizedBox(
              //   width: double.infinity,
              //   height: 140,
              //   child: Card(
              //     child: Align(
              //         alignment: Alignment.center,
              //         child: Text('Day vice Chart')),
              //   ),
              // ),
              Chart(expense),
              Expanded(
                  child: Scrollbar(
                      isAlwaysShown: false,
                      showTrackOnHover: true,
                      thickness: 10,
                      child: SingleChildScrollView(
                          child: SortBy(
                        expense: expense,
                        sortby: initialValue,
                      ))))
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: btnshow,
          child: FloatingActionButton(
            //mouseCursor: SystemMouseCursors.click,
            onPressed: () {
              _show = true;
              setState(() {
                btnshow = false;
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomSheet: _showBottomSheet(),
      ),
    );
  }

  Widget? _showBottomSheet() {
    if (_show) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _show = false;
                          btnshow = true;
                        });
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                  ),
                  TextField(
                    controller: _itemtitle,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: const TextStyle(color: Colors.black),
                      errorText:
                          isItemNameValid ? null : '* Item Name is Required',
                    ),
                  ),
                  Text(
                    isDubKey
                        ? '* Item name is Already taken, Please enter another Name!'
                        : '',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _itemamount,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: const TextStyle(color: Colors.black),
                      errorText: isAmountValid ? null : '* Amount is Required',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dateTime == null
                            ? 'No date Choosen!'
                            : 'Picked Date : ${DateFormat.yMd().format(_dateTime)}',
                      ),
                      TextButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100))
                              .then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        },
                        child: const Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Text(
                    isDateValid == false ? '* Date is Required!' : '',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      validateClearButton() == true
                          ? ElevatedButton(
                              onPressed: () {
                                _itemtitle.clear();
                                _itemamount.clear();
                                _dateTime = null;
                              },
                              //style: ElevatedButton.styleFrom(primary: Colors.purple),
                              child: Text('Clear Data'))
                          : Container(),
                      ElevatedButton.icon(
                        style: validateAddTxnButton()
                            ? ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor)
                            : ElevatedButton.styleFrom(primary: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _itemtitle.text.isEmpty
                                ? isItemNameValid = false
                                : isItemNameValid = true;
                            _itemamount.text.isEmpty
                                ? isAmountValid = false
                                : isAmountValid = true;
                            _dateTime == null
                                ? isDateValid = false
                                : isDateValid = true;
                            expense.containsKey(_itemtitle.text)
                                ? isDubKey = true
                                : isDubKey = false;
                          });
                          if (isItemNameValid == true &&
                              isAmountValid == true &&
                              isDateValid == true &&
                              isDubKey == false) {
                            expense[_itemtitle.text] = {
                              'price': int.parse(_itemamount.text),
                              'date': _dateTime,
                            };
                            print(expense);
                            _itemtitle.clear();
                            _itemamount.clear();
                            _dateTime = null;
                            setState(() {
                              isTransactionAdded = !isTransactionAdded;
                            });
                            Future.delayed(Duration(seconds: 2), () {
                              setState(() {
                                isTransactionAdded = !isTransactionAdded;
                                _show = true;
                              });
                            });
                          }
                        },
                        icon: Icon(isTransactionAdded == true
                            ? Icons.check
                            : Icons.add),
                        label: Text(isTransactionAdded == true
                            ? 'Added Successfully'
                            : 'Add Transaction'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return null;
    }
  }
}
