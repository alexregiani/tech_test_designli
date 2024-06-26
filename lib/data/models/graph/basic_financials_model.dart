import 'package:tech_test_designli/core/typedefs.dart';
import 'package:tech_test_designli/data/models/graph/models/series_model.dart';
import 'package:tech_test_designli/domain/entities/graph/basic_financials_entity.dart';

class BasicFinancialsModel extends BasicFinancialsEntity {
  BasicFinancialsModel({
    required super.symbol,
    required super.series,
  });
  factory BasicFinancialsModel.fromJson(JSON json) {
    return BasicFinancialsModel(
      symbol: json['symbol'] as String,
      series: SeriesModel.fromJson(json['series'] as JSON),
    );
  }
}
