class TradesRealTimeEntity {
  TradesRealTimeEntity({
    required this.lastPrice,
    required this.symbol,
    required this.timestamp,
    required this.volume,
    required this.conditions,
  });
  final double lastPrice;
  final String symbol;
  final int timestamp;
  final double volume;
  final List<String> conditions;

  @override
  String toString() {
    return 'TradesRealTimeEntity{lastPrice: $lastPrice, symbol: $symbol, '
        'timestamp: $timestamp, volume: $volume, conditions: $conditions}';
  }
}
