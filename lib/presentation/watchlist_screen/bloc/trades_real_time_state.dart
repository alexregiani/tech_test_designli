part of 'trades_real_time_bloc.dart';

sealed class TradesRealTimeState extends Equatable {
  const TradesRealTimeState();
}

final class TradesRealTimeInitialState extends TradesRealTimeState {
  @override
  List<Object> get props => [];
}

final class TradesRealTimeLoadingState extends TradesRealTimeState {
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
