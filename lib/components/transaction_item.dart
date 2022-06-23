import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'dart:math';

class TransactionItem extends StatefulWidget {
  final String Function(double p1) _formatedValue;
  final Transaction transaction;
  final void Function(String p1) onRemove;

  const TransactionItem({
    Key? key,
    required String Function(double p1) formatedValue,
    required this.transaction,
    required this.onRemove,
  })  : _formatedValue = formatedValue,
        super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.purple,
    Colors.red,
    Colors.blue,
    Colors.orange,
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();

    int i = Random().nextInt(4);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
              child: Text(
                widget._formatedValue(widget.transaction.value),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat('d MMM y').format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 470
            ? ElevatedButton.icon(
                onPressed: () => widget.onRemove(widget.transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Remover'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => widget.onRemove(widget.transaction.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
