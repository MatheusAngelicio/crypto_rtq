import '../../domain/entities/ticker_entity.dart';

class TickerModel extends TickerEntity {
  const TickerModel({required super.symbol, required super.price});

  factory TickerModel.fromMap(Map<String, dynamic> map) {
    return TickerModel(symbol: map['s'], price: double.tryParse(map['p']) ?? 0);
  }
}
