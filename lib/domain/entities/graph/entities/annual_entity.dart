import 'package:tech_test_designli/domain/entities/graph/entities/eps_entity.dart';

class AnnualEntity {
  AnnualEntity({required this.eps});

  final List<EpsEntity> eps;

  @override
  String toString() {
    return 'Annual{eps: $eps}';
  }
}
