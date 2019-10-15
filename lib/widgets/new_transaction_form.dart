import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionForm extends StatefulWidget {
  final Function callback;

  NewTransactionForm({@required this.callback});

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _executeCallbackWithParams() {
    final _titleInput = _titleController.text;
    final _amountInput = double.tryParse(_amountController.text);

    if (_titleInput.isEmpty || _amountInput <= 0 || _selectedDate == null) {
      return;
    }

    widget.callback(_titleInput, _amountInput, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: _titleController,
              onSubmitted: (_) => _executeCallbackWithParams,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Amount',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child:
                        Icon(Icons.euro_symbol, size: 18, color: Colors.grey),
                  )),
              controller: _amountController,
              onSubmitted: (_) => _executeCallbackWithParams,
            ),
            Container(
              height: 70,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(_selectedDate != null
                          ? DateFormat.yMMMd().format(_selectedDate)
                          : "No date selected")),
                  // IconButton(
                  // color: Theme.of(context).primaryColor,
                  // icon: Icon(Icons.calendar_today),
                  // onPressed: _showDatePicker,
                  // ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      "Select date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text('Add Transaction'),
                onPressed: _executeCallbackWithParams,
              ),
            )
          ],
        ),
      ),
    );
  }
}
