import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_test_designli/core/configuration_service.dart';
import 'package:tech_test_designli/core/custom_exception.dart';
import 'package:tech_test_designli/core/dio_exception_handler.dart';
import 'package:tech_test_designli/core/stocks_symbol_enum.dart';
import 'package:tech_test_designli/core/typedefs.dart';
import 'package:tech_test_designli/data/data_sources/trades_data_source.dart';
import 'package:tech_test_designli/data/models/company_stock_model.dart';
import 'package:tech_test_designli/data/models/trades_real_time_model.dart';
import 'package:tech_test_designli/domain/use_cases/stock_company_use_case.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TradesDataSourceImplementation implements TradesDataSource {
  TradesDataSourceImplementation(this._configService);
  final ConfigurationService _configService;
  WebSocketChannel? _channel;
  final Duration _reconnectDelay = const Duration(seconds: 5);
  bool _isConnected = false;
  late StreamController<Map<String, TradesRealTimeModel>> _streamController;

  @override
  Stream<Map<String, TradesRealTimeModel>> tradesRealTimeNetwork() {
    _streamController =
        StreamController<Map<String, TradesRealTimeModel>>.broadcast();
    _startListening();
    return _streamController.stream;
  }

  Future<void> _startListening() async {
    final tradesMap = <String, TradesRealTimeModel>{};

    while (true) {
      if (!_isConnected) {
        try {
          await _connect();
        } on WebSocketChannelException catch (e) {
          debugPrint('webSocket channel exception $e');
          _isConnected = false;
          await Future<void>.delayed(_reconnectDelay);
          continue;
        } on WebSocketException catch (e) {
          debugPrint('WebSocket exception: $e');
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

            for (final trade in trades) {
              tradesMap[trade.symbol] = trade;
            }
            _streamController.add(tradesMap);
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
    _channel = WebSocketChannel.connect(Uri.parse(_configService.wsUrl));
    await _channel!.ready;
    _isConnected = true;
    debugPrint('Connected to WebSocket');
    _channel!.sink.add(
      jsonEncode(
        {'type': 'subscribe', 'symbol': StocksSymbol.apple.symbol},
      ),
    );
    _channel!.sink.add(
      jsonEncode(
        {
          'type': 'subscribe',
          'symbol': StocksSymbol.binance.symbol,
        },
      ),
    );
    _channel!.sink.add(
      jsonEncode({
        'type': 'subscribe',
        'symbol': StocksSymbol.microsoft.symbol,
      }),
    );
    _channel!.sink.add(
      jsonEncode(
        {'type': 'subscribe', 'symbol': StocksSymbol.amazon.symbol},
      ),
    );
  }

  void dispose() {
    _channel?.sink.close();
    _isConnected = false;
    _streamController.close();
  }

  @override
  Future<CompanyStockModel> stockCompanyNetwork({
    required ParamsStockCompany params,
  }) async {
    final url =
        'https://finnhub.io/api/v1/quote?symbol=${params.symbol}&token=cpt1s1hr01qpk40rpu40cpt1s1hr01qpk40rpu4g';

    try {
      final dio = Dio();
      final response = await dio.get<dynamic>(url);

      final result = CompanyStockModel.fromJson(response.data as JSON);
      debugPrint(result.toString());
      return result;
    } on DioException catch (e) {
      throw DioExceptionHandler.handle(e);
    } catch (e) {
      throw CustomException('An unexpected error occurred: $e');
    }
  }
}
