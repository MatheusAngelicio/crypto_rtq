import 'dart:convert';
import 'package:crypto_rtq/core/config/api_config.dart';
import 'package:crypto_rtq/core/utils/app_logger.dart';
import 'package:crypto_rtq/data/datasources/ticker/ticker_stream_datasource.dart';
import 'package:crypto_rtq/data/models/ticker_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TickerStreamDatasourceImpl implements TickerStreamDatasource {
  final Map<String, WebSocketChannel> _channels = {};

  @override
  Stream<TickerModel> connect(String symbol) {
    final wsUrl = ApiConfig.wsUrl;
    final lowerSymbol = symbol.toLowerCase();
    final url = '$wsUrl/$lowerSymbol@trade';

    if (!_channels.containsKey(symbol)) {
      try {
        _channels[symbol] = WebSocketChannel.connect(Uri.parse(url));
        AppLogger.success('[WebSocket] Connected successfully: $symbol');
      } catch (e) {
        AppLogger.error('[WebSocket] Connection failed with $symbol: $e');
        rethrow;
      }
    }

    final channel = _channels[symbol]!;

    return channel.stream.map((event) {
      try {
        final data = jsonDecode(event);
        return TickerModel.fromWsJson(data);
      } catch (e) {
        AppLogger.error('[WebSocket] Error processing message: $e');
        throw Exception('Error processing WebSocket data');
      }
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
