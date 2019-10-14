import 'package:flutter/material.dart';

import 'widgets/new_transaction_form.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';
import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense Tracker',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.amberAccent,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'OpenSans', fontSize: 18)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: "t1",
        title: "Test Driven Laravel",
        amount: 150.89,
        date: DateTime.now()),
    Transaction(
        id: "t1",
        title: "Flutter courses",
        amount: 40.12,
        date: DateTime.now()),
    Transaction(
        id: "t2",
        title: "Laravel Internals Course",
        amount: 60.21,
        date: DateTime.now()),
    Transaction(
        id: "t3",
        title: "PHP Design Patterns book",
        amount: 50.55,
        date: DateTime.now()),
    Transaction(
        id: "t1",
        title: "Philip K. Dick Vol.3",
        amount: 20.82,
        date: DateTime.now()),
    Transaction(
        id: "t2",
        title: "Refactoring To Collections",
        amount: 90.29,
        date: DateTime.now()),
    Transaction(
        id: "t3",
        title: "PHP Data Structures",
        amount: 52.55,
        date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount) {
    final newTransaction = new Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _pullUpNewTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builderContext) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactionForm(callback: _addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart, color: Colors.white),
            onPressed: () => _pullUpNewTransactionForm(context),
          )
        ],
        title: Text("Personal Expense Tracker"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(recentTransactions: _recentTransactions),
          TransactionList(transactions: _transactions),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () => _pullUpNewTransactionForm(context),
      ),
    );
  }
}
