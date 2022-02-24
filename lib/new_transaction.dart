import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  const NewTransaction(this._addTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  dynamic _pickedDate;

  void _submitData() async {
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);
    if (_enteredTitle.isEmpty || _enteredAmount < 0 || _pickedDate == null) {
      return;
    }
    // widget is used to access data from the main/parent class of this state
    await widget._addTransaction(_enteredTitle, _enteredAmount, _pickedDate);
    // close the upper screen
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_pickedDate == null
                        ? 'No date chosen!'
                        : DateFormat.yMMMd().format(_pickedDate)),
                  ),
                  IconButton(
                    onPressed: _openDatePicker,
                    icon: const Icon(Icons.calendar_month_outlined),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Add transaction'),
            )
          ],
        ),
      ),
    );
  }
}
