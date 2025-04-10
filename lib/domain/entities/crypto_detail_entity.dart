import 'package:equatable/equatable.dart';

class CryptoDetailEntity extends Equatable {
  final String symbol;
  final String lastPrice;
  final String highPrice;
  final String lowPrice;
  final String priceChangePercent;

  const CryptoDetailEntity({
    required this.symbol,
    required this.lastPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.priceChangePercent,
  });

  @override
  List<Object?> get props => [
    symbol,
    lastPrice,
    highPrice,
    lowPrice,
    priceChangePercent,
  ];
}
