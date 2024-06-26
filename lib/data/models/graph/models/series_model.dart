import 'package:tech_test_designli/core/typedefs.dart';
import 'package:tech_test_designli/data/models/graph/models/annual_model.dart';
import 'package:tech_test_designli/domain/entities/graph/entities/series_entity.dart';

class SeriesModel extends SeriesEntity {
  SeriesModel({required super.annual});

  factory SeriesModel.fromJson(JSON json) {
    return SeriesModel(
      annual: AnnualModel.fromJson(json['annual'] as JSON),
    );
  }
}
