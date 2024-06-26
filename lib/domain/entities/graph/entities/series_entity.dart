import 'package:tech_test_designli/domain/entities/graph/entities/annual_entity.dart';

class SeriesEntity {
  SeriesEntity({required this.annual});
  final AnnualEntity annual;

  @override
  String toString() {
    return 'Series{annual: $annual}';
  }
}
