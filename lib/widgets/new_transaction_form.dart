import 'package:flutter/material.dart';

class NewTransactionForm extends StatefulWidget {

  final Function callback;

  NewTransactionForm({@required this.callback});

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void executeCallbackWithParams() {
    final titleInput = titleController.text;
    final amountInput = double.tryParse(amountController.text);

    if(titleInput.isEmpty || amountInput <= 0){
      return;
    }

    widget.callback(titleInput, amountInput);
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: titleController,
              // onSubmitted: (_) => executeCallbackWithParams,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount', suffixIcon: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(Icons.euro_symbol, size: 18, color: Colors.grey),
              )),
              controller: amountController,
              // onSubmitted: (_) => executeCallbackWithParams,
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Add Transaction'),
                onPressed: executeCallbackWithParams,
              ),
            )
          ],
        ),
      ),
    );
  }
}
