import 'package:tech_test_designli/domain/entities/graph/entities/series_entity.dart';

class BasicFinancialsEntity {
  BasicFinancialsEntity({
    required this.symbol,
    required this.series,
  });

  final String symbol;
  final SeriesEntity series;

  @override
  String toString() {
    return 'BasicFinancialsEntity{symbol: $symbol, series: $series}';
  }
}
