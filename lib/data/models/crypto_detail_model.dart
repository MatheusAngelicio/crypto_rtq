import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';

class CryptoDetailModel {
  final String symbol;
  final String lastPrice;
  final String highPrice;
  final String lowPrice;
  final String priceChangePercent;

  CryptoDetailModel({
    required this.symbol,
    required this.lastPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.priceChangePercent,
  });

  factory CryptoDetailModel.fromJson(Map<String, dynamic> json) {
    return CryptoDetailModel(
      symbol: json['symbol'],
      lastPrice: json['lastPrice'],
      highPrice: json['highPrice'],
      lowPrice: json['lowPrice'],
      priceChangePercent: json['priceChangePercent'],
    );
  }

  CryptoDetailEntity toEntity() {
    return CryptoDetailEntity(
      symbol: symbol,
      lastPrice: lastPrice,
      highPrice: highPrice,
      lowPrice: lowPrice,
      priceChangePercent: priceChangePercent,
    );
  }
}
