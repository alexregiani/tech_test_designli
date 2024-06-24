import 'package:tech_test_designli/core/typedefs.dart';
import 'package:tech_test_designli/domain/entities/trades_real_time_entity.dart';

class TradesRealTimeModel extends TradesRealTimeEntity {
  TradesRealTimeModel({
    required super.lastPrice,
    required super.symbol,
    required super.timestamp,
    required super.volume,
    required super.conditions,
  });
  factory TradesRealTimeModel.fromJson(JSON json) {
    return TradesRealTimeModel(
      lastPrice: (json['p'] as num).toDouble(),
      symbol: json['s'] as String,
      timestamp: json['t'] as int,
      volume: (json['v'] as num).toDouble(),
      conditions: json['c'] != null
          ? (json['c'] as List<dynamic>).map((e) => e.toString()).toList()
          : [],
    );
  }
}
