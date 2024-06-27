import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_test_designli/core/go_router.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_trades_real_time/trades_real_time_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TradesRealTimeBloc, TradesRealTimeState>(
      listener: (context, state) {
        if (state is AlertTriggeredState) {
          final symbol = state.symbol;
          final alertPrice = state.alertPrice;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 5),
              content: Text(
                'Your alert for the $symbol stock has reached \$$alertPrice',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: MyColors.designlyDarkBlue,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyColors.designlyOrange,
          title: Text(
            'Designli Test by Alex Regiani',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 20),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.designlyOrange,
                ),
                onPressed: () {
                  context.goNamed(Navigation.watchListScreen.name);
                },
                child: const Text(
                  style: TextStyle(color: MyColors.designlyDarkBlue),
                  'Watch Screen',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.designlyOrange,
                ),
                onPressed: () {
                  context.goNamed(Navigation.alertScreen.name);
                },
                child: const Text(
                  style: TextStyle(color: MyColors.designlyDarkBlue),
                  'Alert Screen',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.designlyOrange,
                ),
                onPressed: () {
                  context.goNamed(Navigation.graphScreen.name);
                },
                child: const Text(
                  style: TextStyle(color: MyColors.designlyDarkBlue),
                  'Graph Screen',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
