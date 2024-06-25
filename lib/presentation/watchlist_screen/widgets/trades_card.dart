import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tech_test_designli/core/my_theme.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: MyColors.designlyOrange,
              duration: const Duration(seconds: 3),
              content: Text(state.error),
            ),
          );
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
                    trades.lastPrice.toString(),
                  ),
                const Text('1.47(888.19)'),
              ],
            ),
          );
        } else if (state is TradesRealTimeFailureState) {
          return const Card(
            elevation: 20,
            shadowColor: MyColors.designlyOrange,
            child: Column(
              children: [Text('Error')],
            ),
          );
        } else if (state is TradesRealTimeLoadingState) {
          return const Skeletonizer(
            child: Card(
              child: Column(
                children: [
                  Text(
                    'AAAAAA',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    style: TextStyle(fontSize: 30),
                    '111111',
                  ),
                  Text('1111111'),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
