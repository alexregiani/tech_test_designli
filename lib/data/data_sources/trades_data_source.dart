import 'package:tech_test_designli/data/models/single_company_stock_model.dart';
import 'package:tech_test_designli/data/models/trades_real_time_model.dart';

abstract class TradesDataSource {
  Stream<List<TradesRealTimeModel>> tradesRealTimeNetwork();
  Future<SingleCompanyStockModel> stockCompanyNetwork();
}
