import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tech_test_designli/data/data_sources/trades_data_source.dart';
import 'package:tech_test_designli/data/models/trades_real_time_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
//
// class TradesDataSourceImplementation implements TradesDataSource {
//   // final String _wsUrl =
//   //     'wss://ws.finnhub.io?token=cpsqsn9r01qpk40rjbe0cpsqsn9r01qpk40rjbeg';
//   final String _wsUrl = 'ws://10.0.2.2:8080';
//   WebSocketChannel? _channel;
//   final Duration _reconnectDelay = const Duration(seconds: 5);
//
//   @override
//   Stream<List<TradesRealTimeModel>> tradesRealTimeNetwork() async* {
//     while (true) {
//       try {
//         _channel = WebSocketChannel.connect(Uri.parse(_wsUrl));
//         _channel!.sink.add(
//             jsonEncode({'type': 'subscribe', 'symbol': 'BINANCE:BTCUSDT'}));
//         _channel!.sink.add(jsonEncode({
//           {"type": "subscribe", "symbol": "AAPL"}
//         }));
//         await for (final message in _channel!.stream) {
//           final decodedMessage =
//               jsonDecode(message as String) as Map<String, dynamic>;
//           if (decodedMessage['type'] == 'trade' &&
//               decodedMessage['data'] != null) {
//             final tradeData = decodedMessage['data'] as List<dynamic>;
//             final trades = tradeData
//                 .map(
//                   (trade) => TradesRealTimeModel.fromJson(
//                       trade as Map<String, dynamic>),
//                 )
//                 .toList();
//             yield trades;
//           }
//         }
//       } on WebSocketChannelException catch (e) {
//         debugPrint('WebSocket error: $e');
//         yield [];
//         await Future<void>.delayed(_reconnectDelay);
//         throw Exception('error channel');
//         throw CustomException(error: 'error general');
//       } finally {
//         await _channel?.sink.close();
//       }
//     }
//   }
//
//   void dispose() {
//     _channel?.sink.close();
//   }
// }

class TradesDataSourceImplementation implements TradesDataSource {
  final String _wsUrl = 'ws://10.0.2.2:8080';
  WebSocketChannel? _channel;
  final Duration _reconnectDelay = const Duration(seconds: 5);
  bool _isConnected = false;

  @override
  Stream<List<TradesRealTimeModel>> tradesRealTimeNetwork() async* {
    while (true) {
      if (!_isConnected) {
        try {
          await _connect();
        } on WebSocketChannelException catch (e) {
          debugPrint('WebSocket connection error: $e');
          _isConnected = false;
          await Future<void>.delayed(_reconnectDelay);
          continue;
        } catch (e) {
          debugPrint('Connection error: $e');
          await Future<void>.delayed(_reconnectDelay);
          continue;
        }
      }

      try {
        await for (final message in _channel!.stream) {
          final decodedMessage =
              jsonDecode(message as String) as Map<String, dynamic>;
          if (decodedMessage['type'] == 'trade' &&
              decodedMessage['data'] != null) {
            final tradeData = decodedMessage['data'] as List<dynamic>;
            final trades = tradeData
                .map(
                  (trade) => TradesRealTimeModel.fromJson(
                    trade as Map<String, dynamic>,
                  ),
                )
                .toList();
            yield trades;
          }
        }
      } catch (e) {
        debugPrint('Stream error: $e');
        _isConnected = false;
        await Future<void>.delayed(_reconnectDelay);
      }
    }
  }

  Future<void> _connect() async {
    _channel = WebSocketChannel.connect(Uri.parse(_wsUrl));
    await _channel!.ready;
    _isConnected = true;
    debugPrint('Connected to WebSocket');
    _channel!.sink.add(jsonEncode({'type': 'subscribe', 'symbol': 'AAPL'}));
  }

  void dispose() {
    _channel?.sink.close();
    _isConnected = false;
  }
}
