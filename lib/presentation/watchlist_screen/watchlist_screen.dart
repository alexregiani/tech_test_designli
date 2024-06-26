import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tech_test_designli/core/go_router.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/core/stocks_symbol_enum.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_company_stock/bloc_company_stock_bloc.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_trades_real_time/trades_real_time_bloc.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/widgets/live_stock_trade.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CompanyStockBloc>().add(AppleStockTriggerEvent());
    context.read<CompanyStockBloc>().add(BinanceStockTriggerEvent());
    return BlocListener<TradesRealTimeBloc, TradesRealTimeState>(
      listener: (context, state) {
        if (state is AlertTriggeredState) {
          final symbol = state.symbol;
          final alertPrice = state.alertPrice;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 5),
              content: Text(
                'Your alert for the $symbol stock has reached $alertPrice',
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: MyColors.designlyDarkBlue,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Watch Live Trades',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 28),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.goNamed(Navigation.homeScreen.name),
          ),
          backgroundColor: MyColors.designlyOrange,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                LiveStockTrade(
                  symbol: StocksSymbol.binance.symbol,
                ),
                BlocBuilder<CompanyStockBloc, CompanyStockState>(
                  builder: (context, state) {
                    if (state.binanceStatus == CompanyStockStatus.loading) {
                      return Skeletonizer(
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Text(
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    fontSize: 20,
                                  ),
                              '0000000000000',
                            ),
                          ),
                        ),
                      );
                    } else if (state.binanceStatus ==
                        CompanyStockStatus.success) {
                      final percentChange =
                          state.binanceStock?.percentChange ?? 0.0;
                      final change = state.binanceStock?.change ?? 0.0;
                      final formattedChange =
                          formatStockChange(percentChange, change);

                      return SizedBox(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  formattedChange,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        color: change >= 0
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 15,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (state.binanceStatus ==
                        CompanyStockStatus.failure) {
                      return Card(
                        margin: EdgeInsets.zero,
                        child: Text(state.binanceError ?? ''),
                      );
                    } else {
                      return SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Text(
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontSize: 20,
                                ),
                            '',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            const Gap(30),
            Column(
              children: [
                LiveStockTrade(
                  symbol: StocksSymbol.apple.symbol,
                ),
                BlocBuilder<CompanyStockBloc, CompanyStockState>(
                  builder: (context, state) {
                    if (state.appleStatus == CompanyStockStatus.loading) {
                      return Skeletonizer(
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Text(
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    fontSize: 20,
                                  ),
                              '0000000000000',
                            ),
                          ),
                        ),
                      );
                    } else if (state.appleStatus ==
                        CompanyStockStatus.success) {
                      final percentChange =
                          state.appleStock?.percentChange ?? 0.0;
                      final change = state.appleStock?.change ?? 0.0;
                      final formattedChange =
                          formatStockChange(percentChange, change);

                      return SizedBox(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  formattedChange,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        color: change >= 0
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 15,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (state.appleStatus ==
                        CompanyStockStatus.failure) {
                      return SizedBox(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Text(state.appleError ?? ''),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatStockChange(double percentChange, double change) {
    final percentChangeStr = percentChange >= 0
        ? '+${percentChange.toStringAsFixed(2)}'
        : percentChange.toStringAsFixed(2);

    final changeStr = change >= 0
        ? '+\$${change.toStringAsFixed(2)}'
        : '-\$${change.abs().toStringAsFixed(2)}';

    return '$percentChangeStr% ($changeStr)';
  }
}
