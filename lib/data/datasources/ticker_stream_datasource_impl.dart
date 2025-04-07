import 'dart:convert';
import 'package:crypto_rtq/data/datasources/ticker_stream_datasource.dart';
import 'package:crypto_rtq/data/models/ticker_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TickerStreamDatasourceImpl implements TickerStreamDatasource {
  final Map<String, WebSocketChannel> _channels = {};

  @override
  Stream<TickerModel> connect(String symbol) {
    final lowerSymbol = symbol.toLowerCase();
    final url = 'wss://stream.binance.com:9443/ws/$lowerSymbol@trade';

    if (!_channels.containsKey(symbol)) {
      _channels[symbol] = WebSocketChannel.connect(Uri.parse(url));
    }

    final channel = _channels[symbol]!;

    return channel.stream.map((event) {
      final data = jsonDecode(event);
      return TickerModel.fromWsJson(data);
    });
  }

  @override
  void unsubscribe(String symbol) {
    _channels[symbol]?.sink.close();
    _channels.remove(symbol);
  }

  @override
  void dispose() {
    for (final channel in _channels.values) {
      channel.sink.close();
    }
    _channels.clear();
  }
}
