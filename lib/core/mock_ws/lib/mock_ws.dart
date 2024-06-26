import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
  print('WebSocket server listening on ws://0.0.0.0:8080');

  await for (HttpRequest request in server) {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      final socket = await WebSocketTransformer.upgrade(request);
      handleWebSocket(socket);
    }
  }
}

void handleWebSocket(WebSocket socket) {
  print('Client connected');
  Set<String> subscribedSymbols = {};
  Map<String, double> prices = {};

  socket.listen(
    (message) {
      print('Received: $message');
      try {
        final decoded = jsonDecode(message);
        if (decoded is Map &&
            decoded['type'] == 'subscribe' &&
            decoded['symbol'] != null) {
          subscribedSymbols.add(decoded['symbol']);
          prices[decoded['symbol']] = 50; // Start from 150
          print('Subscribed to: ${decoded['symbol']}');
        }
      } catch (e) {
        print('Error processing message: $e');
      }
    },
    onDone: () => print('Client disconnected'),
    onError: (error) => print('Error: $error'),
  );

  Timer.periodic(Duration(seconds: 3), (timer) {
    for (final symbol in subscribedSymbols) {
      prices[symbol] = (prices[symbol] ?? 150.0) + 30.0; // Increase by 30

      final data = {
        "data": [
          {
            "p": prices[symbol]!,
            "s": symbol,
            "t": DateTime.now().millisecondsSinceEpoch,
            "v": 100.0,
            "c": ["1", "2"]
          }
        ],
        "type": "trade"
      };

      socket.add(jsonEncode(data));
      print('Sent: ${jsonEncode(data)}');
    }
  });
}
