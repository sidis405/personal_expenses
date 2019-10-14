import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({@required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 490,
      child: transactions.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var transaction = transactions.reversed.elementAt(index);
                return Card(
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 1,
                          )),
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            "€ ${transaction.amount.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColorLight),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            DateFormat('d MMMM y H:m').format(transaction.date),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ],
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
