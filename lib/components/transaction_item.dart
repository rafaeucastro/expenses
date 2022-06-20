import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
              child: Text(
                _formatedValue(transaction.value),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat('d MMM y').format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 470
            ? ElevatedButton.icon(
                onPressed: () => onRemove(transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text('Remover'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onRemove(transaction.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
