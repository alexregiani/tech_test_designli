part of 'stock_financials_bloc.dart';

sealed class StockFinancialsEvent extends Equatable {
  const StockFinancialsEvent();
}

final class StockFinancialsAppleTriggerEvent extends StockFinancialsEvent {
  const StockFinancialsAppleTriggerEvent({required this.symbol});

  final String symbol;
  @override
  List<Object> get props => [symbol];
}
