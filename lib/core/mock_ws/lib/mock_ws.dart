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

Map<String, int> globalPrices = {};
Timer? globalTimer;

void startGlobalPriceUpdates() {
  globalTimer?.cancel();
  globalTimer = Timer.periodic(
    Duration(seconds: 3),
    (timer) {
      for (final symbol in globalPrices.keys) {
        globalPrices[symbol] = (globalPrices[symbol] ?? 0) + 50;
      }
    },
  );
}

void handleWebSocket(WebSocket socket) {
  Set<String> subscribedSymbols = {};

  socket.listen(
    (message) {
      print('Received: $message');
      try {
        final decoded = jsonDecode(message);
        if (decoded is Map &&
            decoded['type'] == 'subscribe' &&
            decoded['symbol'] != null) {
          final symbol = decoded['symbol'];
          subscribedSymbols.add(symbol);
          if (!globalPrices.containsKey(symbol)) {
            globalPrices[symbol] = 50;
          }
        }
      } catch (e) {
        print('Error processing message: $e');
      }
    },
    onDone: () => print('Client disconnected'),
    onError: (error) => print('Error: $error'),
  );

  if (globalTimer == null || !globalTimer!.isActive) {
    startGlobalPriceUpdates();
  }

  Timer.periodic(
    Duration(seconds: 3),
    (timer) {
      for (final symbol in subscribedSymbols) {
        final price = globalPrices[symbol] ?? 50;

        final data = {
          "data": [
            {
              "p": price,
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
    },
  );
}
