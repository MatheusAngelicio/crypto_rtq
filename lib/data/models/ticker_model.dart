import '../../domain/entities/ticker_entity.dart';

class TickerModel extends TickerEntity {
  const TickerModel({required super.symbol, required super.price});

  factory TickerModel.fromJson(Map<String, dynamic> json) {
    final priceRaw = json['price'];
    final parsedPrice = double.tryParse(priceRaw.toString());

    return TickerModel(
      symbol: json['symbol'] ?? 'UNKNOWN',
      price: parsedPrice ?? 0.0,
    );
  }
}
