class ConfigurationService {
  ConfigurationService({required this.useMockServer});
  final bool useMockServer;
  String get httpUrl => 'https://finnhub.io/api/v1/';
  String get wsUrl => useMockServer
      ? 'ws://10.0.2.2:8080'
      : 'wss://ws.finnhub.io?token=cpt1s1hr01qpk40rpu40cpt1s1hr01qpk40rpu4g';
}
