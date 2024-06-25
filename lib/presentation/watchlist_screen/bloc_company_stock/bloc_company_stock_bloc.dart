import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_test_designli/domain/entities/company_stock_entity.dart';
import 'package:tech_test_designli/domain/use_cases/stock_company_use_case.dart';

part 'bloc_company_stock_event.dart';
part 'bloc_company_stock_state.dart';

class CompanyStockBloc extends Bloc<CompanyStockEvent, CompanyStockState> {
  CompanyStockBloc({required this.stockCompanyUseCase})
      : super(CompanyStockInitialState()) {
    on<CompanyStockTriggerEvent>(_onGetCompanyStockTime);
  }

  Future<void> _onGetCompanyStockTime(
    CompanyStockTriggerEvent event,
    Emitter<CompanyStockState> emit,
  ) async {
    emit(CompanyStockLoadingState());
    try {
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
    } on DioException catch (e) {
      emit(CompanyStockFailureState(error: e.toString()));
    } catch (e) {
      emit(CompanyStockFailureState(error: e.toString()));
    }
  }

  final StockCompanyUseCase stockCompanyUseCase;
}
