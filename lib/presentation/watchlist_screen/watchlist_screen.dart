import 'package:flutter/material.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/widgets/trades_card.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.designlyDarkBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Watch Live Trades',
          style:
              Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
        ),
        backgroundColor: MyColors.designlyOrange,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Real time trade'),
          Row(
            children: [
              Expanded(child: TradesCard()),
              Expanded(child: TradesCard()),
            ],
          ),
          Row(
            children: [
              Expanded(child: TradesCard()),
              Expanded(child: TradesCard()),
            ],
          ),
          Row(
            children: [
              Expanded(child: TradesCard()),
              Expanded(child: TradesCard()),
            ],
          ),
        ],
      ),
    );
  }
}
