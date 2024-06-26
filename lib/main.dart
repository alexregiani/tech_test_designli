// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_test_designli/core/bloc_observer.dart';
import 'package:tech_test_designli/core/get_it/get_it_injection.dart';
import 'package:tech_test_designli/core/go_router.dart';
import 'package:tech_test_designli/core/init_bootsrapper.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/presentation/add_alert_screen/bloc/add_alert_bloc.dart';
import 'package:tech_test_designli/presentation/graph_screen/bloc/stock_financials_bloc.dart';

import 'package:tech_test_designli/presentation/watchlist_screen/bloc_company_stock/bloc_company_stock_bloc.dart';
import 'package:tech_test_designli/presentation/watchlist_screen/bloc_trades_real_time/trades_real_time_bloc.dart';

void main() {
  InitBootstrapper.init();
  Bloc.observer = SimpleBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AddAlertBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CompanyStockBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<TradesRealTimeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<StockFinancialsBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TradesRealTimeBloc>().add(TradesRealTimeTriggerEvent());

    return MaterialApp.router(
      routerConfig: router,
      title: 'Tech Test Designli',
      theme: MyTheme.theme,
    );
  }
}
