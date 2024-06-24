import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';
import 'package:tech_test_designli/domain/repositories/trades_repository.dart';

class RealTimeTradesUseCase {
  RealTimeTradesUseCase({required this.tradesRepository});

  final TradesRepository tradesRepository;

  Stream<List<TradesRealTimeEntity>> tradesRealTime() {
    return tradesRepository.tradesRealTime();
  }
}
