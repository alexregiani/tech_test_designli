import 'package:tech_test_designli/domain/entities/company_stock_entity.dart';
import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';
import 'package:tech_test_designli/domain/use_cases/stock_company_use_case.dart';

abstract class TradesRepository {
  Stream<Map<String, TradesRealTimeEntity>> tradesRealTime();
  Future<CompanyStockEntity> fetchStockCompany({
    required ParamsStockCompany params,
  });
}
