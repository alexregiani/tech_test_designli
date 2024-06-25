import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DesignlyCard extends StatelessWidget {
  const DesignlyCard(
      {required this.symbol,
      required this.lastPrice,
      required this.percentage,
      super.key});
  final String symbol;
  final double lastPrice;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              symbol,
              style: textTheme.displayMedium?.copyWith(fontSize: 25),
            ),
            const Gap(5),
            Text(
              style: textTheme.displayLarge?.copyWith(fontSize: 35),
              lastPrice.toString(),
            ),
            const Gap(5),
            Text(
              style: textTheme.displayMedium?.copyWith(fontSize: 20),
              percentage.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
