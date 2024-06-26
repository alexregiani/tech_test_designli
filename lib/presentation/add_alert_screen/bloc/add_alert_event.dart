part of 'add_alert_bloc.dart';

sealed class AddAlertEvent extends Equatable {
  const AddAlertEvent();
}

final class AddAlertTriggerEvent extends AddAlertEvent {
  const AddAlertTriggerEvent({required this.symbol, required this.alertPrice});

  final String symbol;
  final double alertPrice;

  @override
  List<Object> get props => [symbol, alertPrice];
}
