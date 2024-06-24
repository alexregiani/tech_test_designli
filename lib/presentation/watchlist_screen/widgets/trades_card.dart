import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc/trades_real_time_bloc.dart';

class TradesCard extends StatefulWidget {
  const TradesCard({super.key});

  @override
  State<TradesCard> createState() => _TradesCardState();
}

class _TradesCardState extends State<TradesCard> {
  @override
  void initState() {
    context.read<TradesRealTimeBloc>().add(TradesRealTimeTriggerEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradesRealTimeBloc, TradesRealTimeState>(
      listener: (context, state) {
        if (state is TradesRealTimeFailureState) {
          showDialog<void>(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('error'),
            ),
          );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     duration: const Duration(seconds: 3),
          //     content: Text(state.error),
          //   ),
          // );
        }
      },
      builder: (context, state) {
        if (state is TradesRealTimeSuccessState) {
          final trades = state.tradesRealTime.last;
          return Card(
            child: Column(
              children: [
                Text(
                  trades.symbol,
                  style: const TextStyle(fontSize: 30),
                ),
                if (state.tradesRealTime.isNotEmpty)
                  Text(
                      style: const TextStyle(fontSize: 30),
                      trades.lastPrice.toString()),
              ],
            ),
          );
        } else if (state is TradesRealTimeFailureState) {
          return const Card(
            child: Column(
              children: [Text('Error')],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
