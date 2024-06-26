import 'package:tech_test_designli/core/typedefs.dart';
import 'package:tech_test_designli/domain/entities/graph/entities/eps_entity.dart';

class EpsModel extends EpsEntity {
  EpsModel({
    required super.period,
    required super.value,
  });

  factory EpsModel.fromJson(JSON json) {
    return EpsModel(
      period: json['period'] as String,
      value: json['v'] as double,
    );
  }
}
