import 'package:tech_test_designli/data/data_sources/trades_data_source.dart';
import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';
import 'package:tech_test_designli/domain/repositories/trades_repository.dart';

class TradesRepositoryImplementation implements TradesRepository {
  TradesRepositoryImplementation({
    required this.tradesDataSource,
  });

  final TradesDataSource tradesDataSource;
  @override
  Stream<Map<String, TradesRealTimeEntity>> tradesRealTime() {
    return tradesDataSource.tradesRealTimeNetwork();
  }
}
