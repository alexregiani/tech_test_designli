enum StocksSymbol {
  apple('AAPL'),
  binance('BINANCE:BTCUSDT');

  const StocksSymbol(this.symbol);
  final String symbol;
}
