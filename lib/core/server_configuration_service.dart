import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServerConfigurationService {
  ServerConfigurationService({required this.useMockServer});
  final bool useMockServer;
  String get httpUrl => 'https://finnhub.io/api/v1/';
  String get wsUrl {
    final token = dotenv.env['FINNHUB_API_TOKEN'] ?? '';
    return useMockServer
        ? 'ws://10.0.2.2:8080'
        : 'wss://ws.finnhub.io?token=$token';
  }
}
