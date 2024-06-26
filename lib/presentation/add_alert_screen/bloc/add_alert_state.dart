part of 'add_alert_bloc.dart';

sealed class AddAlertState extends Equatable {
  const AddAlertState();
}

final class AddAlertInitialState extends AddAlertState {
  @override
  List<Object> get props => [];
}

final class AddAlertLoadingState extends AddAlertState {
  @override
  List<Object> get props => [];
}

final class AddAlertSuccessState extends AddAlertState {
  @override
  List<Object> get props => [];
}

class AddAlertTriggeredState extends AddAlertState {
  const AddAlertTriggeredState({
    required this.symbol,
    required this.triggerPrice,
    required this.alertPrice,
  });
  final String symbol;
  final double triggerPrice;
  final double alertPrice;

  @override
  List<Object> get props => [symbol, triggerPrice];
}

final class AddAlertFailureState extends AddAlertState {
  const AddAlertFailureState({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
