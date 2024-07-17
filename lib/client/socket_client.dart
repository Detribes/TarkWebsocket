import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:test_app/models/ticker.dart';
import 'package:test_app/util/constants.dart';
import 'package:web_socket_channel/io.dart';

@singleton
class SocketClient {
  late IOWebSocketChannel _channel;
  late StreamController<List<Ticker>> _tickerStreamController;
  String _currentStreamUrl = '$BASE_URL/!miniTicker@arr';
  bool _isConnected = false;

  SocketClient() {
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    _channel = IOWebSocketChannel.connect(_currentStreamUrl);
    _tickerStreamController = StreamController<List<Ticker>>.broadcast(
      onListen: _startListening,
      onCancel: closeWebSocket,
    );
    _isConnected = true;
  }

  Stream<List<Ticker>> connectToTickerStream(String query) {
    String streamUrl = query.isEmpty ? '$BASE_URL/!miniTicker@arr' : '$BASE_URL/$query@miniTicker';
    if (!_isConnected || streamUrl != _currentStreamUrl) {
      _currentStreamUrl = streamUrl;
      _reconnectWebSocket();
    }
    _startListening();
    return _tickerStreamController.stream;
  }

  void _reconnectWebSocket() {
    closeWebSocket();
    _initializeWebSocket();
  }

  void _startListening() {
    _channel.stream.listen(
          (message) {
        try {
          if(_currentStreamUrl.contains("!miniTicker@arr")) {
            final List<dynamic> tickerDataList = jsonDecode(message);
            List<Ticker> tickers = tickerDataList
                .map((tickerData) => Ticker.fromJson(tickerData))
                .toList();
            _tickerStreamController.add(tickers);
          } else {
            final Map<String, dynamic> tickerData = jsonDecode(message);
            if (tickerData.containsKey('e') && tickerData['e'] == '24hrMiniTicker') {
              List<Ticker> tickers = [Ticker.fromJson(tickerData)]; // Assuming Ticker.fromJson exists
              _tickerStreamController.add(tickers);
            } else {
              log('Unknown message format: $message');
            }
          }
        } catch (e) {
          log('Error decoding WebSocket message: $e');
          _tickerStreamController.addError(e); // Pass error downstream
        }
      },
      onError: (error) {
        log('WebSocket stream error: $error');
        _tickerStreamController.addError(error); // Pass error downstream
      },
      onDone: () {
        log('WebSocket stream closed');
        _tickerStreamController.close();
      },
    );
  }

  void closeWebSocket() {
    _isConnected = false;
    _tickerStreamController.close();
    _channel.sink.close();
  }
}