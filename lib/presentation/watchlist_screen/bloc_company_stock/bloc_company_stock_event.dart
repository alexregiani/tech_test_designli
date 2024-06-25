part of 'bloc_company_stock_bloc.dart';

sealed class CompanyStockEvent extends Equatable {
  const CompanyStockEvent();
}

final class CompanyStockTriggerEvent extends CompanyStockEvent {
  const CompanyStockTriggerEvent({required this.symbol});

  final String symbol;
  @override
  List<Object> get props => [symbol];
}
