import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final String Function(double) _formatedValue;

  const TransactionList(this.transactions, this.onRemove, this._formatedValue,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text("Nenhuma transação cadastrada!",
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.6,
                  child: Image.asset(
                    'assets\\images\\waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final transaction = transactions[index];
              return TransactionItem(
                key: GlobalObjectKey(transaction),
                formatedValue: _formatedValue,
                transaction: transaction,
                onRemove: onRemove,
              );
            },
          );
  }
}
