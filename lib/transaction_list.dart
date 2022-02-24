import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  const TransactionList(this.userTransactions, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView  works inside containera and must define height on container
    return Container(
      height: 300,
      child: userTransactions.isNotEmpty
          ? ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  child: Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '\$${userTransactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userTransactions[index].title,
                          // using global texstyle
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          DateFormat.yMMMd()
                              .format(userTransactions[index].transactionDate),
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )
                  ]),
                );
              },
              itemCount: userTransactions.length,
            )
          : Column(
              children: [
                const Text('No transaction'),
                const SizedBox(height: 20,),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/test.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
    );
  }
}
