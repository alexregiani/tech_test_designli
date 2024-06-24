import 'dart:convert';

import 'package:tech_test_designli/core/typedefs.dart';
import 'package:tech_test_designli/data/data_sources/trades_data_source.dart';
import 'package:tech_test_designli/data/models/trades_real_time_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TradesDataSourceImplementation implements TradesDataSource {
  final String _wsUrl =
      'wss://ws.finnhub.io?token=cpsqsn9r01qpk40rjbe0cpsqsn9r01qpk40rjbeg';
  late WebSocketChannel _channel;

  @override
  Stream<List<TradesRealTimeModel>> tradesRealTimeNetwork() async* {
    _channel = WebSocketChannel.connect(Uri.parse(_wsUrl));
    _channel.sink
        .add(jsonEncode({'type': 'subscribe', 'symbol': 'BINANCE:BTCUSDT'}));
    _channel.sink.add(jsonEncode({'type': 'subscribe', 'symbol': 'AAPL'}));
    await for (final message in _channel.stream) {
      final decodedMessage = jsonDecode(message as String) as JSON;
      if (decodedMessage['type'] == 'trade' && decodedMessage['data'] != null) {
        final tradeData = decodedMessage['data'] as List<dynamic>;
        final trades = tradeData
            .map((trade) => TradesRealTimeModel.fromJson(trade as JSON))
            .toList();
        yield trades;
      }
    }
  }

  void dispose() {
    _channel.sink.close();
  }
}
