// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  List<Transaction> transactions = [
    Transaction(
      id: '1',
      title: 'Shoes',
      amount: 2.0,
      transactionDate: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'Bag',
      amount: 92.0,
      transactionDate: DateTime.now(),
    ),
    Transaction(
      id: '3',
      title: 'Cellphone',
      amount: 62.0,
      transactionDate: DateTime.now(),
    ),
    Transaction(
      id: '4',
      title: 'Motor',
      amount: 72.0,
      transactionDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              color: Colors.red,
              elevation: 5,
              child: SizedBox(
                width: double.infinity,
                child: Text('chart'),
              ),
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const TextField(
                      decoration: InputDecoration(labelText: 'User'),
                    ),
                    const TextField(
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Add transaction'),
                      style: TextButton.styleFrom(
                        primary: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: transactions
                  .map((transaction) => Card(
                        elevation: 5,
                        child: Row(children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 2,
                                ),
                                color: Colors.purple[400]),
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '\$${transaction.amount}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd()
                                    .format(transaction.transactionDate),
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          )
                        ]),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
