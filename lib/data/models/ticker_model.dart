import '../../domain/entities/ticker_entity.dart';

class TickerModel extends TickerEntity {
  TickerModel({required super.symbol, required super.price});

  factory TickerModel.fromWsJson(Map<String, dynamic> json) {
    return TickerModel(
      symbol: json['s'],
      price: double.tryParse(json['p']) ?? 0,
    );
  }
}
