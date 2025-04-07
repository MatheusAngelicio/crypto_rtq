import 'package:crypto_rtq/core/utils/app_logger.dart';
import 'package:dio/dio.dart';
import '../../core/config/api_config.dart';
import '../models/ticker_model.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceDatasource {
  final Dio dio;

  BinanceDatasource(this.dio);

  Future<List<TickerModel>> getPrices() async {
    try {
      final response = await dio.get('${ApiConfig.baseUrl}/ticker/price');
      final data = response.data as List;

      AppLogger.success('Successfully fetched ${data.length} prices');

      return data.map((json) => TickerModel.fromJson(json)).toList();
    } catch (e) {
      AppLogger.error('Failed to fetch prices: $e');
      rethrow;
    }
  }

  Stream<TickerModel> subscribeTicker(String symbol) {
    final channel = WebSocketChannel.connect(
      Uri.parse('${ApiConfig.wsUrl}/$symbol@ticker'),
    );

    return channel.stream.map((event) {
      final json = jsonDecode(event);
      final ticker = TickerModel.fromJson(json);
      AppLogger.info(
        '🔄 Update: ${ticker.symbol} = \$${ticker.price.toStringAsFixed(2)}',
      );
      return ticker;
    });
  }
}
