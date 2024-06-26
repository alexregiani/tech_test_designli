import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';
import 'package:tech_test_designli/domain/use_cases/real_time_trades_use_case.dart';

part 'add_alert_event.dart';
part 'add_alert_state.dart';

class AddAlertBloc extends Bloc<AddAlertEvent, AddAlertState> {
  AddAlertBloc({required this.realTimeTradesUseCase})
      : super(AddAlertInitialState()) {
    on<AddAlertTriggerEvent>(_onSetAlertPrice);
  }
  final RealTimeTradesUseCase realTimeTradesUseCase;

  Future<void> _onSetAlertPrice(
    AddAlertTriggerEvent event,
    Emitter<AddAlertState> emit,
  ) async {
    final symbol = event.symbol;
    final alertPrice = event.alertPrice;
    final realTimeTrades = realTimeTradesUseCase.tradesRealTime();

    var alertTriggered = false;

    await emit.forEach(
      realTimeTrades,
      onData: (Map<String, TradesRealTimeEntity> trades) {
        if (!alertTriggered && trades.containsKey(symbol)) {
          final trade = trades[symbol]!;
          if (trade.lastPrice >= alertPrice) {
            alertTriggered = true;
            return AddAlertTriggeredState(
              alertPrice: alertPrice,
              symbol: symbol,
              triggerPrice: trade.lastPrice,
            );
          }
        }
        return state;
      },
    );
  }
}
