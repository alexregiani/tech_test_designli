import 'package:tech_test_designli/data/data_sources/trades_data_source.dart';
import 'package:tech_test_designli/domain/entities/company_stock_entity.dart';
import 'package:tech_test_designli/domain/entities/graph/basic_financials_entity.dart';
import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';
import 'package:tech_test_designli/domain/repositories/trades_repository.dart';
import 'package:tech_test_designli/domain/use_cases/stock_company_use_case.dart';
import 'package:tech_test_designli/domain/use_cases/stock_financials_use_case.dart';

class TradesRepositoryImplementation implements TradesRepository {
  TradesRepositoryImplementation({
    required this.tradesDataSource,
  });

  final TradesDataSource tradesDataSource;
  @override
  Stream<Map<String, TradesRealTimeEntity>> tradesRealTime() {
    return tradesDataSource.tradesRealTimeNetwork();
  }

  @override
  Future<CompanyStockEntity> fetchStockCompany({
    required ParamsStockCompany params,
  }) async {
    return tradesDataSource.stockCompanyNetwork(params: params);
  }

  @override
  Future<BasicFinancialsEntity> fetchStockFinancials(
      {required ParamsStockFinancials params}) {
    return tradesDataSource.fetchStockFinancialsNetwork(params: params);
  }
}
