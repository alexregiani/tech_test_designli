part of 'trades_real_time_bloc.dart';

sealed class TradesRealTimeEvent extends Equatable {
  const TradesRealTimeEvent();
}

final class TradesRealTimeTriggerEvent extends TradesRealTimeEvent {
  @override
  List<Object> get props => [];
}

class SetAlertEvent extends TradesRealTimeEvent {
  const SetAlertEvent({required this.symbol, required this.alertPrice});
  final String symbol;
  final double alertPrice;

  @override
  List<Object> get props => [symbol, alertPrice];
}
