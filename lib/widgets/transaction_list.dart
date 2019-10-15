import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;

  TransactionList({@required this.transactions, @required this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 490,
      child: transactions.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var transaction = transactions.reversed.elementAt(index);
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                            child: Text(
                                "€ ${transaction.amount.toStringAsFixed(2)}"))),
                    title: Text(
                      transaction.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => delete(transaction.id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            )
          : Column(
              children: [
                Text(
                  'There are no transacitons available.',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 590,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            ),
    );
  }
}
