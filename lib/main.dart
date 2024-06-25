import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test_designli/core/get_it/get_it_injection.dart';
import 'package:tech_test_designli/core/init_bootsrapper.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_company_stock/bloc_company_stock_bloc.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_trades_real_time/trades_real_time_bloc.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/watchlist_screen.dart';

void main() {
  InitBootstrapper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Test Designli',
      theme: MyTheme.theme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<TradesRealTimeBloc>()),
          BlocProvider(
            create: (context) => sl<CompanyStockBloc>(),
          )
        ],
        child: const WatchlistScreen(),
      ),
    );
  }
}
