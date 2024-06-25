enum StocksSymbol {
  apple('AAPL'),
  binance('BINANCE:BTCUSDT'),
  microsoft('MSFT'),
  amazon('AMZN');

  const StocksSymbol(this.symbol);
  final String symbol;
}
