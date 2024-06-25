import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc/trades_real_time_bloc.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/widgets/designly_card.dart';

class LiveStockTrade extends StatefulWidget {
  const LiveStockTrade({
    required this.symbol,
    super.key,
  });
  final String symbol;

  @override
  State<LiveStockTrade> createState() => _LiveStockTradeState();
}

class _LiveStockTradeState extends State<LiveStockTrade> {
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
          final symbol = state.tradesRealTime[widget.symbol];

          return DesignlyCard(
            symbol: symbol?.symbol ?? '',
            lastPrice: symbol?.lastPrice ?? 0,
            percentage: 0,
          );
        } else if (state is TradesRealTimeFailureState) {
          return const Card(
            child: Column(
              children: [Text('Error loading')],
            ),
          );
        } else if (state is TradesLoadingState) {
          return Skeletonizer(
            effect: ShimmerEffect(
              baseColor: Colors.grey.withOpacity(0.1),
            ),
            child: const DesignlyCard(
              symbol: 'AAAAA',
              lastPrice: 111111,
              percentage: 11111,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
