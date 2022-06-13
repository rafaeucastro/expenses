import 'package:expenses/components/adaptative_text_field.dart';
import 'package:expenses/components/adaptive_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _submitForm() {
      final title = _titleController.text;
      final value = double.tryParse(_valueController.text) ?? 0.0;

      if (title.isEmpty || value <= 0) return null;

      widget.onSubmit(title, value, _selectedDate);
    }

    _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) return;
        setState(() {
          _selectedDate = pickedDate;
        });
      });
    }

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: [
            AdaptativeTextField(
              controller: _titleController,
              submitForm: (value) => _submitForm(),
              label: 'Título',
            ),
            AdaptativeTextField(
              controller: _valueController,
              submitForm: (value) => _submitForm(),
              label: 'Valor (R\$)',
              textInputType: const TextInputType.numberWithOptions(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == DateTime.now()
                          ? "Nenhuma data selecionada!"
                          : "Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}",
                    ),
                  ),
                  TextButton(
                      onPressed: _showDatePicker,
                      child: const Text(
                        'Selecionar Data',
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton('Nova Transação', _submitForm),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
