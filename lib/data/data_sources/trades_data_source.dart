import 'package:tech_test_designli/data/models/trades_real_time_model.dart';

abstract class TradesDataSource {
  Stream<List<TradesRealTimeModel>> tradesRealTimeNetwork();
}
