import 'dart:convert';
import 'package:crypto_rtq/core/config/api_config.dart';
import 'package:crypto_rtq/core/exception/crypto_exception.dart';
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
        throw CryptoException('Failed to connect to WebSocket for $symbol.');
      }
    }

    final channel = _channels[symbol]!;

    return channel.stream.map((event) {
      try {
        final data = jsonDecode(event);
        return TickerModel.fromWsJson(data);
      } catch (e) {
        AppLogger.error('[WebSocket] Error processing message for $symbol: $e');
        throw CryptoException('Error processing WebSocket data for $symbol.');
      }
    });
  }

  @override
  void unsubscribe(String symbol) {
    try {
      _channels[symbol]?.sink.close();
      _channels.remove(symbol);
      AppLogger.success('[WebSocket] Unsubscribed from $symbol');
    } catch (e) {
      AppLogger.error('[WebSocket] Error unsubscribing from $symbol: $e');
      throw CryptoException('Failed to unsubscribe from $symbol.');
    }
  }

  @override
  void dispose() {
    try {
      for (final channel in _channels.values) {
        channel.sink.close();
      }
      _channels.clear();
      AppLogger.success('[WebSocket] All channels closed and disposed.');
    } catch (e) {
      AppLogger.error('[WebSocket] Error disposing channels: $e');
      throw CryptoException('Failed to dispose WebSocket channels.');
    }
  }
}
