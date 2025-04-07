import '../../domain/entities/ticker_entity.dart';

class TickerModel extends TickerEntity {
  const TickerModel({required super.symbol, required super.price});

  factory TickerModel.fromJson(Map<String, dynamic> json) {
    return TickerModel(
      symbol: json['s'],
      price: double.tryParse(json['c'] ?? '0') ?? 0.0,
    );
  }
}
