import 'package:tech_test_designli/data/models/company_stock_model.dart';
import 'package:tech_test_designli/data/models/graph/basic_financials_model.dart';
import 'package:tech_test_designli/data/models/trades_real_time_model.dart';
import 'package:tech_test_designli/domain/use_cases/stock_company_use_case.dart';

abstract class TradesDataSource {
  Stream<Map<String, TradesRealTimeModel>> tradesRealTimeNetwork();
  Future<CompanyStockModel> stockCompanyNetwork({
    required ParamsStockCompany params,
  });
  Future<BasicFinancialsModel> fetchFinancialsNetwork();
}
