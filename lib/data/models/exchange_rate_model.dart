import 'package:crypto_rtq/domain/entities/exchange_rate_entity.dart';

class ExchangeRateModel extends ExchangeRateEntity {
  const ExchangeRateModel({required super.symbol, required super.price});

  factory ExchangeRateModel.fromMap(Map<String, dynamic> map) {
    return ExchangeRateModel(symbol: map['symbol'], price: map['price']);
  }

  Map<String, dynamic> toMap() {
    return {'symbol': symbol, 'price': price};
  }
}
