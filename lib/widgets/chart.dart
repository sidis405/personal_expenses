import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({@required this.recentTransactions});

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double sumOfDay = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          sumOfDay += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sumOfDay
      };
    });
  }

  double get totalSpending {
    return _groupedTransactions.fold(0.0, (sum, el) {
      return sum + el['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions.map((item) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: item['day'],
                  amount: item['amount'],
                  percentageOfTotal: totalSpending == 0.0
                      ? 0.0
                      : (item['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
