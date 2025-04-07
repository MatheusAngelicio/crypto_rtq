import 'package:dio/dio.dart';
import '../../core/config/api_config.dart';
import '../models/ticker_model.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceDatasource {
  final Dio dio;

  BinanceDatasource(this.dio);

  Future<List<TickerModel>> getPrices() async {
    final response = await dio.get('${ApiConfig.baseUrl}/ticker/24hr');
    final data = response.data as List;
    return data.map((json) => TickerModel.fromJson(json)).toList();
  }

  Stream<TickerModel> subscribeTicker(String symbol) {
    final channel = WebSocketChannel.connect(
      Uri.parse('${ApiConfig.wsUrl}/$symbol@ticker'),
    );

    return channel.stream.map((event) {
      final json = jsonDecode(event);
      return TickerModel.fromJson(json);
    });
  }
}
