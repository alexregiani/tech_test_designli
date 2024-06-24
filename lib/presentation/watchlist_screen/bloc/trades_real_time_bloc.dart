import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_test_designli/core/custom_exception.dart';
import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';
import 'package:tech_test_designli/domain/use_cases/real_time_trades_use_case.dart';

part 'trades_real_time_event.dart';
part 'trades_real_time_state.dart';

class TradesRealTimeBloc
    extends Bloc<TradesRealTimeEvent, TradesRealTimeState> {
  TradesRealTimeBloc({required this.realTimeTradesUseCase})
      : super(TradesRealTimeInitialState()) {
    on<TradesRealTimeTriggerEvent>(_onGetTradesRealTime);
  }
  Future<void> _onGetTradesRealTime(
    TradesRealTimeTriggerEvent event,
    Emitter<TradesRealTimeState> emit,
  ) async {
    try {
      await emit.forEach(
        realTimeTradesUseCase.tradesRealTime(),
        onData: (trades) {
          _errorCount = 0;
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
    } on CustomException catch (e) {
      emit(TradesRealTimeFailureState(error: e.toString()));
    }
  }

  int _errorCount = 0;
  final int _errorThreshold = 10;
  final RealTimeTradesUseCase realTimeTradesUseCase;
}
