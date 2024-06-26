import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';
import 'package:tech_test_designli/domain/use_cases/real_time_trades_use_case.dart';

part 'trades_real_time_event.dart';
part 'trades_real_time_state.dart';

class TradesRealTimeBloc
    extends Bloc<TradesRealTimeEvent, TradesRealTimeState> {
  TradesRealTimeBloc({
    required this.realTimeTradesUseCase,
  }) : super(TradesRealTimeInitialState()) {
    on<TradesRealTimeTriggerEvent>(_onGetTradesRealTime);
    on<SetAlertEvent>(_onSetAlert);
  }

  final RealTimeTradesUseCase realTimeTradesUseCase;
  final Map<String, double> _alerts = {};
  int _errorCount = 0;
  static const int _errorThreshold = 3;
  Map<String, TradesRealTimeEntity> _currentTrades = {};

  Future<void> _onGetTradesRealTime(
    TradesRealTimeTriggerEvent event,
    Emitter<TradesRealTimeState> emit,
  ) async {
    try {
      emit(TradesLoadingState());
      await emit.forEach(
        realTimeTradesUseCase.tradesRealTime(),
        onData: (Map<String, TradesRealTimeEntity> trades) {
          _errorCount = 0;
          _currentTrades = trades;

          _checkAlerts(emit);

          return TradesRealTimeSuccessState(tradesRealTime: trades);
        },
        onError: (error, stackTrace) {
          _errorCount++;
          if (_errorCount >= _errorThreshold) {
            return const TradesRealTimeFailureState(error: 'error data');
          }
          return state;
        },
      );
    } catch (e) {
      emit(TradesRealTimeFailureState(error: e.toString()));
    }
  }

  void _onSetAlert(SetAlertEvent event, Emitter<TradesRealTimeState> emit) {
    _alerts[event.symbol] = event.alertPrice;

    if (_currentTrades.containsKey(event.symbol) &&
        _currentTrades[event.symbol]!.lastPrice == event.alertPrice) {
      emit(AlertSetState(symbol: event.symbol, alertPrice: event.alertPrice));
      emit(
        AlertTriggeredState(
          alertPrice: event.alertPrice,
          symbol: event.symbol,
          triggerPrice: _currentTrades[event.symbol]!.lastPrice,
        ),
      );
      _alerts.remove(event.symbol);
    }
  }

  void _checkAlerts(Emitter<TradesRealTimeState> emit) {
    for (final entry in _alerts.entries) {
      final symbol = entry.key;
      final alertPrice = entry.value;
      if (_currentTrades.containsKey(symbol) &&
          _currentTrades[symbol]!.lastPrice >= alertPrice) {
        emit(
          AlertTriggeredState(
            alertPrice: alertPrice,
            symbol: symbol,
            triggerPrice: _currentTrades[symbol]!.lastPrice,
          ),
        );
        _alerts.remove(symbol);
      }
    }
  }
}
