import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_test_designli/core/go_router.dart';
import 'package:tech_test_designli/core/my_theme.dart';
import 'package:tech_test_designli/presentation/graph_screen/bloc/stock_financials_bloc.dart';
import 'package:tech_test_designli/presentation/graph_screen/widgets/line_chart.dart';

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
    context.read<StockFinancialsBloc>().add(StockFinancialsTriggerEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          style:
              Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 25),
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
            const Text('Earnings per Share AAPL'),
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
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
