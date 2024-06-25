part of 'trades_real_time_bloc.dart';

sealed class TradesRealTimeEvent extends Equatable {
  const TradesRealTimeEvent();
}

final class TradesRealTimeTriggerEvent extends TradesRealTimeEvent {
  @override
  List<Object> get props => [];
}

final class CompanyStockTriggerEvent extends TradesRealTimeEvent {
  const CompanyStockTriggerEvent({required this.symbol});

  final String symbol;
  @override
  List<Object> get props => [symbol];
}
