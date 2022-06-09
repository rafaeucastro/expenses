import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final String Function(double) _formatedValue;

  const TransactionList(this.transactions, this.onRemove, this._formatedValue,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * (0.70),
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 20),
                Text("Nenhuma transação cadastrada!",
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets\\images\\waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
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
                            _formatedValue(tr.value),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onRemove(tr.id),
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
