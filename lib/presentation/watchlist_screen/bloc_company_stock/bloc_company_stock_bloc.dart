import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_test_designli/core/dio_exception_handler.dart';
import 'package:tech_test_designli/core/stocks_symbol_enum.dart';
import 'package:tech_test_designli/domain/entities/company_stock_entity.dart';
import 'package:tech_test_designli/domain/use_cases/stock_company_use_case.dart';

part 'bloc_company_stock_event.dart';
part 'bloc_company_stock_state.dart';

class CompanyStockBloc extends Bloc<CompanyStockEvent, CompanyStockState> {
  CompanyStockBloc({required this.stockCompanyUseCase})
      : super(const CompanyStockState()) {
    on<AppleStockTriggerEvent>(_onGetAppleStockTime);
    on<BinanceStockTriggerEvent>(_onGetBinanceStockTime);
  }

  Future<void> _onGetAppleStockTime(
    AppleStockTriggerEvent event,
    Emitter<CompanyStockState> emit,
  ) async {
    emit(state.copyWith(appleStatus: CompanyStockStatus.loading));
    try {
      final symbol = StocksSymbol.apple.symbol;
      final result = await stockCompanyUseCase.fetchStockCompany(
        params: ParamsStockCompany(symbol: symbol),
      );
      emit(
        state.copyWith(
          appleStatus: CompanyStockStatus.success,
          appleStock: result,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          appleError: e.toString(),
          appleStatus: CompanyStockStatus.failure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          appleError: e.toString(),
          appleStatus: CompanyStockStatus.failure,
        ),
      );
    }
  }

  Future<void> _onGetBinanceStockTime(
    BinanceStockTriggerEvent event,
    Emitter<CompanyStockState> emit,
  ) async {
    emit(state.copyWith(binanceStatus: CompanyStockStatus.loading));
    try {
      final symbol = StocksSymbol.binance.symbol;
      final result = await stockCompanyUseCase.fetchStockCompany(
        params: ParamsStockCompany(symbol: symbol),
      );
      emit(
        state.copyWith(
          binanceStatus: CompanyStockStatus.success,
          binanceStock: result,
        ),
      );
    } on DioException catch (e) {
      final customException = DioExceptionHandler.handle(e);
      emit(
        state.copyWith(
          binanceError: customException.error,
          binanceStatus: CompanyStockStatus.failure,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          binanceError: 'An unexpected error occurred: $e',
          binanceStatus: CompanyStockStatus.failure,
        ),
      );
    }
  }

  final StockCompanyUseCase stockCompanyUseCase;
}
