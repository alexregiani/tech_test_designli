import 'package:tech_test_designli/domain/entities/graph/basic_financials_entity.dart';
import 'package:tech_test_designli/domain/repositories/trades_repository.dart';

class StockFinancialsUseCase {
  StockFinancialsUseCase({required this.tradesRepository});

  final TradesRepository tradesRepository;

  Future<BasicFinancialsEntity> stockFinancials(
    ParamsStockFinancials params,
  ) async {
    return tradesRepository.fetchStockFinancials(params: params);
  }
}

class ParamsStockFinancials {
  ParamsStockFinancials({required this.symbol});

  final String symbol;
}
