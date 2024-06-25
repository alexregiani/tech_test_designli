import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tech_test_designli/core/my_theme.dart';

class DesignlyCard extends StatelessWidget {
  const DesignlyCard({
    required this.symbol,
    required this.lastPrice,
    super.key,
  });
  final String symbol;
  final double lastPrice;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    const darkBlue = MyColors.designlyDarkBlue;
    return SizedBox(
      height: 100,
      width: screenWidth,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                symbol,
                style: textTheme.displayMedium
                    ?.copyWith(fontSize: 17, color: darkBlue),
              ),
              const Gap(5),
              Text(
                style: textTheme.displayLarge
                    ?.copyWith(color: darkBlue, fontSize: 35),
                lastPrice.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
