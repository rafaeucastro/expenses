import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _submitForm() {
      final title = titleController.text;
      final value = double.tryParse(valueController.text) ?? 0.0;

      if (title.isEmpty || value <= 0) return;

      widget.onSubmit(title, value);
    }

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(
            onSubmitted: (value) => _submitForm(),
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
            onSubmitted: (value) => _submitForm(),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: valueController,
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text(
              'Nova Transação',
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
