class EpsEntity {
  EpsEntity({required this.period, required this.value});

  final String period;
  final double value;

  @override
  String toString() {
    return 'EpsEntity{period: $period, value: $value}';
  }
}
