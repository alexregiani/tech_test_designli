part of 'trades_real_time_bloc.dart';

sealed class TradesRealTimeState extends Equatable {
  const TradesRealTimeState();
}

class AlertTriggeredState extends TradesRealTimeState {
  const AlertTriggeredState({
    required this.symbol,
    required this.alertPrice,
    required this.triggerPrice,
  });
  final String symbol;
  final double alertPrice;
  final double triggerPrice;

  @override
  List<Object> get props => [symbol, alertPrice, triggerPrice];
}

final class TradesRealTimeInitialState extends TradesRealTimeState {
  @override
  List<Object> get props => [];
}

final class TradesLoadingState extends TradesRealTimeState {
  @override
  List<Object> get props => [];
}

final class TradesRealTimeSuccessState extends TradesRealTimeState {
  const TradesRealTimeSuccessState({required this.tradesRealTime});

  final Map<String, TradesRealTimeEntity> tradesRealTime;

  @override
  List<Object> get props => [tradesRealTime];
}

final class TradesRealTimeFailureState extends TradesRealTimeState {
  const TradesRealTimeFailureState({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}

class AlertSetState extends TradesRealTimeState {
  const AlertSetState({required this.symbol, required this.alertPrice});

  final String symbol;
  final double alertPrice;

  @override
  List<Object> get props => [symbol, alertPrice];
}
