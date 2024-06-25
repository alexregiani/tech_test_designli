part of 'bloc_company_stock_bloc.dart';

sealed class CompanyStockEvent extends Equatable {
  const CompanyStockEvent();
}

final class AppleStockTriggerEvent extends CompanyStockEvent {
  @override
  List<Object> get props => [];
}

final class BinanceStockTriggerEvent extends CompanyStockEvent {
  @override
  List<Object> get props => [];
}
