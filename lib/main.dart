import 'dart:math';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'components/transaction_list.dart';
import 'components/chart.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
          colorScheme: tema.colorScheme
              .copyWith(primary: Colors.purple, secondary: Colors.amber),
          textTheme: tema.textTheme.copyWith(
              headline6: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransactions(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransactions);
        });
  }

  @override
  Widget build(BuildContext context) {
    String _formatedValue(double value) {
      double K = 1000.0;
      double M = 1000000.0;
      double B = 1000000000.0;
      if (value >= B) {
        return 'R\$${(value / B).toStringAsFixed(2)}B';
      } else if (value >= M) {
        return 'R\$${(value / M).toStringAsFixed(2)}M';
      } else if (value >= K) {
        return 'R\$${(value / K).toStringAsFixed(2)}K';
      }
      return 'R\$${value.toStringAsFixed(2)}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Despesas Pessoais",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: const Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions, _formatedValue),
            TransactionList(_transactions, _removeTransaction, _formatedValue),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
