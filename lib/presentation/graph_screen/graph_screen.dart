import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_test_designli/core/go_router.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/core/stocks_symbol_enum.dart';
import 'package:tech_test_designli/presentation/graph_screen/bloc/stock_financials_bloc.dart';
import 'package:tech_test_designli/presentation/graph_screen/widgets/line_chart.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_trades_real_time/trades_real_time_bloc.dart';

class GraphScreenProviderWrapper extends StatelessWidget {
  const GraphScreenProviderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const GraphScreen();
  }
}

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StockFinancialsBloc>().add(
          StockFinancialsAppleTriggerEvent(
            symbol: StocksSymbol.apple.symbol,
          ),
        );
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
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 25),
            'Graph Screen',
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.goNamed(Navigation.homeScreen.name),
          ),
          backgroundColor: MyColors.designlyOrange,
        ),
        body: Center(
          child: Column(
            children: [
              const Gap(50),
              Text(
                  style: Theme.of(context).textTheme.displayMedium,
                  'Earnings per Share ${StocksSymbol.apple.symbol}'),
              SizedBox(
                height: 300,
                child: BlocBuilder<StockFinancialsBloc, GraphState>(
                  builder: (context, state) {
                    if (state is StockFinancialsSuccessState) {
                      final appleFlSpots = state.stockFlSpots;
                      return SizedBox(
                        width: 380,
                        child: MyLineChart(
                          spots: appleFlSpots,
                          isShowingMainData: true,
                        ),
                      );
                    } else if (state is StockFinancialsFailureState) {
                      return const Text(
                        'Failed to load graph',
                        style: TextStyle(color: Colors.black),
                      );
                    } else if (state is StockFinancialsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
