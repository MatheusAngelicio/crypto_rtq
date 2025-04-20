import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';

class CryptoDetailModel extends CryptoDetailEntity {
  const CryptoDetailModel({
    required super.symbol,
    required super.lastPrice,
    required super.highPrice,
    required super.lowPrice,
    required super.priceChangePercent,
  });

  factory CryptoDetailModel.fromMap(Map<String, dynamic> map) {
    return CryptoDetailModel(
      symbol: map['symbol'],
      lastPrice: map['lastPrice'],
      highPrice: map['highPrice'],
      lowPrice: map['lowPrice'],
      priceChangePercent: map['priceChangePercent'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'lastPrice': lastPrice,
      'highPrice': highPrice,
      'lowPrice': lowPrice,
      'priceChangePercent': priceChangePercent,
    };
  }
}
