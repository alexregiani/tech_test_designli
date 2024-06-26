import 'package:tech_test_designli/core/typedefs.dart';
import 'package:tech_test_designli/data/models/graph/models/eps_model.dart';
import 'package:tech_test_designli/domain/entities/graph/entities/annual_entity.dart';

class AnnualModel extends AnnualEntity {
  AnnualModel({required super.eps});

  factory AnnualModel.fromJson(JSON json) {
    return AnnualModel(
      eps: (json['eps'] as List<dynamic>)
          .map((e) => EpsModel.fromJson(e as JSON))
          .toList(),
    );
  }
}
