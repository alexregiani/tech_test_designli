import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tech_test_designli/domain/entities/graph/entities/eps_entity.dart';
import 'package:tech_test_designli/domain/use_cases/stock_financials_use_case.dart';

part 'stock_financials_event.dart';
part 'stock_financials_state.dart';

class StockFinancialsBloc extends Bloc<StockFinancialsEvent, GraphState> {
  StockFinancialsBloc({required this.stockFinancialsUseCase})
      : super(StockFinancialsInitialState()) {
    on<StockFinancialsTriggerEvent>(_onBasicFinancials);
  }

  Future<void> _onBasicFinancials(
    StockFinancialsTriggerEvent event,
    Emitter<GraphState> emit,
  ) async {
    emit(StockFinancialsLoadingState());

    final result = await stockFinancialsUseCase.stockFinancials(
      ParamsStockFinancials(
        symbol: 'AAPL',
      ),
    );
    final eps = result.series.annual.eps;
    final convert = transformEpsDataToSpots(eps);

    emit(
      StockFinancialsSuccessState(
        stockFlSpots: convert,
      ),
    );
  }

  List<FlSpot> transformEpsDataToSpots(List<EpsEntity> epsData) {
    return epsData
        .map((eps) {
          final year = int.parse(eps.period.split('-')[0]);
          return FlSpot(year.toDouble(), eps.value);
        })
        .toList()
        .reversed
        .toList();
  }

  final StockFinancialsUseCase stockFinancialsUseCase;
}
