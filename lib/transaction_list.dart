import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function removeTransaction;
  const TransactionList(this.userTransactions, this.removeTransaction,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    // SingleChildScrollView  works inside containera and must define height on container
    return userTransactions.isNotEmpty
        ? ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                            '\$${userTransactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    userTransactions[index].title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd()
                        .format(userTransactions[index].transactionDate),
                  ),
                  trailing: mediaquery.size.width > 360
                      ? TextButton.icon(
                          
                          label: const Text('Delete', style: TextStyle(color: Colors.red),),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              removeTransaction(userTransactions[index].id),
                        )
                      : IconButton(
                          onPressed: () =>
                              removeTransaction(userTransactions[index].id),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                ),
              );
              // Card(
              //   elevation: 5,
              //   child: Row(children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Theme.of(context).primaryColor,
              //           width: 2,
              //         ),
              //       ),
              //       margin: const EdgeInsets.symmetric(
              //         vertical: 10,
              //         horizontal: 15,
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Text(
              //           '\$${userTransactions[index].amount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             color: Theme.of(context).primaryColor,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           userTransactions[index].title,
              //           // using global texstyle
              //           style: Theme.of(context).textTheme.headline4,
              //         ),
              //         Text(
              //           DateFormat.yMMMd()
              //               .format(userTransactions[index].transactionDate),
              //           style: const TextStyle(
              //             fontStyle: FontStyle.italic,
              //             color: Colors.grey,
              //           ),
              //         )
              //       ],
              //     )
              //   ]),
              // );
            },
            itemCount: userTransactions.length,
          )
        : LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  const Text(
                    'No transaction',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/test.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          );
  }
}
