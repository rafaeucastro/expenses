import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final String value;
  final double percentage;

  const ChartBar({
    required this.label,
    required this.percentage,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 30,
          padding: const EdgeInsets.all(5),
          child: FittedBox(
            child: Text(
              textAlign: TextAlign.center,
              value,
            ),
          ),
        ),
        SizedBox(
          height: 70,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(label),
        ),
      ],
    );
  }
}
