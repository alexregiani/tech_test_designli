import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tech_test_designli/core/configuration_service.dart';
import 'package:tech_test_designli/core/get_it/get_it_injection.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/data/data_sources/trades_data_source_implementation.dart';
import 'package:tech_test_designli/domain/use_cases/stock_company_use_case.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_company_stock/bloc_company_stock_bloc.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/widgets/live_stock_trade.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<CompanyStockBloc>()
        .add(const CompanyStockTriggerEvent(symbol: 'BINANCE:BTCUSDT'));
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              final result = await TradesDataSourceImplementation(
                sl<ConfigurationService>(),
              ).stockCompanyNetwork(
                params: ParamsStockCompany(symbol: 'BINANCE:BTCUSDT'),
              );
              debugPrint('stock result $result');
            },
            child: const Text('test http'),
          ),
          const Text('Real time trade'),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const LiveStockTrade(
                      symbol: 'BINANCE:BTCUSDT',
                    ),
                    BlocBuilder<CompanyStockBloc, CompanyStockState>(
                      builder: (context, state) {
                        if (state is CompanyStockLoadingState) {
                          return const Skeletonizer(
                            child: Card(
                              child: Text('0000'),
                            ),
                          );
                        } else if (state is CompanyStockSuccessState) {
                          final lowPrice = state.companyStock.lowPriceDay;
                          return Card(
                            margin: EdgeInsets.zero,
                            child: Text(lowPrice.toString()),
                          );
                        } else if (state is CompanyStockFailureState) {
                          return Card(
                            margin: EdgeInsets.zero,
                            child: Text(state.error),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
                  ],
                ),
              ),
              const Expanded(
                child: LiveStockTrade(
                  symbol: 'AAPL',
                ),
              ),
            ],
          ),
          const Gap(20),
          const Row(
            children: [
              Expanded(
                child: LiveStockTrade(
                  symbol: 'AMZN',
                ),
              ),
              Expanded(
                child: LiveStockTrade(
                  symbol: 'MSFT',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
