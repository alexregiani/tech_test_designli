import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';

abstract class TradesRepository {
  Stream<List<TradesRealTimeEntity>> tradesRealTime();
}
