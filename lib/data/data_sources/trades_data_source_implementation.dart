import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tech_test_designli/core/custom_exception.dart';
import 'package:tech_test_designli/data/data_sources/trades_data_source.dart';
import 'package:tech_test_designli/data/models/trades_real_time_model.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class TradesDataSourceImplementation implements TradesDataSource {
  final String _wsUrl =
      'wss://ws.finnhub.io?token=cpsqsn9r01qpk40rjbe0cpsqsn9r01qpk40rjbeg';
  WebSocketChannel? _channel;
  final Duration _reconnectDelay = const Duration(seconds: 5);
  final Duration _connectionTimeout = const Duration(seconds: 10);

  @override
  Stream<List<TradesRealTimeModel>> tradesRealTimeNetwork() async* {
    while (true) {
      try {
        await _connectWebSocket();
        await _subscribeToSymbols();

        await for (final message in _channel!.stream) {
          yield* _processMessage(message);
        }
      } catch (e) {
        debugPrint('WebSocket error: $e');
        yield []; // Yield an empty list to indicate connection issue
        await Future.delayed(_reconnectDelay);
        throw CustomException(error: 'error');
      } finally {
        await _closeWebSocket();
      }
    }
  }

  Future<void> _connectWebSocket() async {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(_wsUrl));
      await _channel!.ready.timeout(_connectionTimeout);
    } on TimeoutException {
      throw CustomException(error: 'WebSocket connection timeout');
    } on SocketException {
      throw CustomException(error: 'Check your internet connection');
    } on WebSocketException {
      throw CustomException(error: 'error ');
    } on WebSocketChannelException {
      throw CustomException(error: 'WebSocket connection failed');
    }
  }

  Future<void> _subscribeToSymbols() async {
    _channel!.sink
        .add(jsonEncode({'type': 'subscribe', 'symbol': 'BINANCE:BTCUSDT'}));
    _channel!.sink.add(jsonEncode({'type': 'subscribe', 'symbol': 'AAPL'}));
  }

  Stream<List<TradesRealTimeModel>> _processMessage(dynamic message) async* {
    try {
      final decodedMessage =
          jsonDecode(message as String) as Map<String, dynamic>;
      if (decodedMessage['type'] == 'trade' && decodedMessage['data'] != null) {
        final tradeData = decodedMessage['data'] as List;
        final trades = tradeData
            .map((trade) =>
                TradesRealTimeModel.fromJson(trade as Map<String, dynamic>))
            .toList();
        yield trades;
      }
    } catch (e) {
      debugPrint('Error processing message: $e');
      yield [];
    }
  }

  Future<void> _closeWebSocket() async {
    await _channel?.sink.close(status.goingAway);
    _channel = null;
  }

  void dispose() {
    _closeWebSocket();
  }
}
