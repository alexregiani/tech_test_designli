import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

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

  socket.listen(
    (message) {
      print('Received: $message');
      try {
        final decoded = jsonDecode(message);
        if (decoded is Map &&
            decoded['type'] == 'subscribe' &&
            decoded['symbol'] != null) {
          subscribedSymbols.add(decoded['symbol']);
          print('Subscribed to: ${decoded['symbol']}');
        }
      } catch (e) {
        print('Error processing message: $e');
      }
    },
    onDone: () {
      print('Client disconnected');
    },
    onError: (error) {
      print('Error: $error');
    },
  );

  Timer.periodic(Duration(seconds: 3), (timer) {
    if (subscribedSymbols.isNotEmpty) {
      for (final symbol in subscribedSymbols) {
        final random = Random();
        final data = {
          "data": [
            {
              "p":
                  double.parse((random.nextDouble() * 1000).toStringAsFixed(2)),
              "s": symbol,
              "t": DateTime.now().millisecondsSinceEpoch,
              "v": double.parse((random.nextDouble() * 100).toStringAsFixed(6)),
              "c": ["1", "2"]
            }
          ],
          "type": "trade"
        };

        final jsonString = jsonEncode(data);
        socket.add(jsonString);
        print('Sent: $jsonString');
      }
    }
  });
}
