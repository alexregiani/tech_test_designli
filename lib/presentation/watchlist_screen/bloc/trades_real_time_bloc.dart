import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_test_designli/domain/entities/company_stock_entity.dart';
import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';
import 'package:tech_test_designli/domain/use_cases/real_time_trades_use_case.dart';
import 'package:tech_test_designli/domain/use_cases/stock_company_use_case.dart';

part 'trades_real_time_event.dart';
part 'trades_real_time_state.dart';

class TradesRealTimeBloc
    extends Bloc<TradesRealTimeEvent, TradesRealTimeState> {
  TradesRealTimeBloc({
    required this.realTimeTradesUseCase,
    required this.stockCompanyUseCase,
  }) : super(TradesRealTimeInitialState()) {
    on<TradesRealTimeTriggerEvent>(_onGetTradesRealTime);
    on<CompanyStockTriggerEvent>(_onGetCompanyStockTime);
  }
  Future<void> _onGetTradesRealTime(
    TradesRealTimeTriggerEvent event,
    Emitter<TradesRealTimeState> emit,
  ) async {
    try {
      emit(TradesLoadingState());
      await emit.forEach(
        realTimeTradesUseCase.tradesRealTime(),
        onData: (trades) {
          debugPrint('print $trades');
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
    } catch (e) {
      emit(TradesRealTimeFailureState(error: e.toString()));
    }
  }

  Future<void> _onGetCompanyStockTime(
    CompanyStockTriggerEvent event,
    Emitter<TradesRealTimeState> emit,
  ) async {
    emit(TradesLoadingState());
    final symbol = event.symbol;
    final result = await stockCompanyUseCase.fetchStockCompany(
      params: ParamsStockCompany(
        symbol: symbol,
      ),
    );
    emit(
      CompanyStockSuccessState(
        companyStock: result,
      ),
    );
  }

  int _errorCount = 0;
  final int _errorThreshold = 10;
  final RealTimeTradesUseCase realTimeTradesUseCase;
  final StockCompanyUseCase stockCompanyUseCase;
}
