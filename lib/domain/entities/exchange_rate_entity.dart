import 'package:equatable/equatable.dart';

class ExchangeRateEntity extends Equatable {
  final String symbol;
  final String price;

  const ExchangeRateEntity({required this.symbol, required this.price});

  @override
  List<Object?> get props => [symbol, price];
}
