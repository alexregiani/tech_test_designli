import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_test_designli/domain/entities/graph/basic_financials_entity.dart';
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
    emit(
      StockFinancialsSuccessState(
        basicFinancial: result,
      ),
    );
  }

  final StockFinancialsUseCase stockFinancialsUseCase;
}
