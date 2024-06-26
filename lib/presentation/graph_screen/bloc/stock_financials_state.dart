part of 'stock_financials_bloc.dart';

sealed class GraphState extends Equatable {
  const GraphState();
}

final class StockFinancialsInitialState extends GraphState {
  @override
  List<Object> get props => [];
}

final class StockFinancialsLoadingState extends GraphState {
  @override
  List<Object> get props => [];
}

final class StockFinancialsSuccessState extends GraphState {
  const StockFinancialsSuccessState({required this.basicFinancial});

  final BasicFinancialsEntity basicFinancial;
  @override
  List<Object> get props => [basicFinancial];
}

final class StockFinancialsFailureState extends GraphState {
  @override
  List<Object> get props => [];
}
