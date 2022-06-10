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
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            margin: EdgeInsets.symmetric(
              vertical: constraints.maxHeight * 0.025,
              horizontal: 5,
            ),
            child: FittedBox(
              child: Text(
                textAlign: TextAlign.center,
                value,
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.6,
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
          Container(
            width: double.infinity,
            height: constraints.maxHeight * 0.15,
            margin: EdgeInsets.symmetric(
              vertical: constraints.maxHeight * 0.025,
              horizontal: 20,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
            ),
          ),
        ],
      );
    });
  }
}
