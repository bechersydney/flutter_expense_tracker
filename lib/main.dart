// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';
import './chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
            headline4: const TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        fontFamily: 'QuickSand',
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: const TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
              .headline6,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      transactionDate: date,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void showAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> get recentTransaction {
    return _userTransactions.where((tx) {
      return tx.transactionDate.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx)=> tx.id == id );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          Builder(builder: (ctx) {
            return IconButton(
              onPressed: () => showAddTransaction(ctx),
              icon: const Icon(Icons.add),
            );
          }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(recentTransaction),
          TransactionList(_userTransactions, _deleteTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(builder: (ctx) {
        return FloatingActionButton(
          onPressed: () => showAddTransaction(ctx),
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        );
      }),
    );
  }
}
