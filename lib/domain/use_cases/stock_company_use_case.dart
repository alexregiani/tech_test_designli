import 'package:tech_test_designli/domain/entities/company_stock_entity.dart';
import 'package:tech_test_designli/domain/repositories/trades_repository.dart';

class StockCompanyUseCase {
  StockCompanyUseCase({required this.tradesRepository});

  final TradesRepository tradesRepository;

  Future<CompanyStockEntity> fetchStockCompany({
    required ParamsStockCompany params,
  }) {
    return tradesRepository.fetchStockCompany(params: params);
  }
}

class ParamsStockCompany {
  ParamsStockCompany({required this.symbol});

  final String symbol;
}
