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
  const StockFinancialsSuccessState({required this.stockFlSpots});

  final List<FlSpot> stockFlSpots;
  @override
  List<Object> get props => [stockFlSpots];
}

final class StockFinancialsFailureState extends GraphState {
  const StockFinancialsFailureState({required this.error});

  final String error;
  @override
  List<Object> get props => [error];
}
