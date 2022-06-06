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
      home: MyHomePage(),
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
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: "Celular novo",
      value: 920.65,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: "Novo tênis de corrida",
      value: 220.65,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: "Conta de Luz",
      value: 9999311.2,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransactions(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas Pessoais"),
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
            Chart(_recentTransactions),
            TransactionList(_transactions),
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
