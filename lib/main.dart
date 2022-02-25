// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';
import './chart.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    // DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown // disable orientations
  ]);
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
        buttonTheme: ThemeData.light().buttonTheme.copyWith(),
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
  bool _isChartView = false;

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
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final _isIOS = Platform.isIOS;
    final bool _isLandscape = mediaquery.orientation == Orientation.landscape;

    final dynamic _appbar = _isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Expense Tracker',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () {},
                )
              ],
            ),
          )
        : AppBar(
            title: const Text('Expense Tracker'),
            actions: [
              Builder(builder: (ctx) {
                return IconButton(
                  onPressed: () => showAddTransaction(ctx),
                  icon: const Icon(Icons.add),
                );
              }),
            ],
          );

    final txListWidget = SizedBox(
      height: (mediaquery.size.height -
              _appbar.preferredSize.height -
              mediaquery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Switch to chart view',
                      style: Theme.of(context).textTheme.headline4),
                  Switch.adaptive(
                      value: _isChartView,
                      onChanged: (val) {
                        setState(() {
                          _isChartView = val;
                        });
                      }),
                ],
              ),
            if (!_isLandscape)
              SizedBox(
                height: (mediaquery.size.height -
                        _appbar.preferredSize.height -
                        mediaquery.padding.top) *
                    0.3,
                child: Chart(recentTransaction),
              ),
            if (!_isLandscape) txListWidget,
            _isChartView
                ? SizedBox(
                    height: (mediaquery.size.height -
                            _appbar.preferredSize.height -
                            mediaquery.padding.top) *
                        0.7,
                    child: Chart(recentTransaction),
                  )
                : txListWidget
          ],
        ),
      ),
    );
    return _isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
          )
        : Scaffold(
            appBar: _appbar,
            body: _pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Builder(builder: (ctx) {
              return _isIOS
                  ? const SizedBox()
                  : FloatingActionButton(
                      onPressed: () => showAddTransaction(ctx),
                      child: const Icon(Icons.add),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    );
            }),
          );
  }
}
