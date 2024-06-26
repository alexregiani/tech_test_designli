part of 'stock_financials_bloc.dart';

sealed class StockFinancialsEvent extends Equatable {
  const StockFinancialsEvent();
}

final class StockFinancialsTriggerEvent extends StockFinancialsEvent {
  @override
  List<Object> get props => [];
}
