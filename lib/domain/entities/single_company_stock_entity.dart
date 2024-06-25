class SingleCompanyStockEntity {
  SingleCompanyStockEntity({
    required this.currentPrice,
    required this.change,
    required this.percentChange,
    required this.highPriceDay,
    required this.openPriceDay,
    required this.lowPriceDay,
    required this.previousClosePrice,
    required this.timestamp,
  });

  final double currentPrice;
  final double change;
  final double percentChange;
  final double highPriceDay;
  final double openPriceDay;
  final double lowPriceDay;
  final double previousClosePrice;
  final int timestamp;

  @override
  String toString() {
    return 'SingleCompanyStockEntity{currentPrice: $currentPrice, change: '
        ' $change, percentChange: $percentChange, highPriceDay: $highPriceDay,'
        ' openPriceDay: $openPriceDay, lowPriceDay: '
        ' $lowPriceDay, previousClosePrice:'
        ' $previousClosePrice, timestamp: $timestamp}';
  }
}
