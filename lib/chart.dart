import 'package:flutter/material.dart';
import './chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double sum = 0;
      for (var transaction in recentTransactions) {
        if (transaction.transactionDate.day == weekday.day &&
            transaction.transactionDate.month == weekday.month &&
            transaction.transactionDate.year == weekday.year) {
          sum += transaction.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': sum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransaction.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransaction.map(
              (tx) {
                return Expanded(
                  child: ChartBar(
                      label: tx['day'].toString(),
                      amount: (tx['amount'] as double),
                      spendingPicTotal: totalSpending == 0
                          ? 0.0
                          : (tx['amount'] as double) / totalSpending),
                );
              },
            ).toList()),
      ),
    );
  }
}
