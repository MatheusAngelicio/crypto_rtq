import 'package:equatable/equatable.dart';

class TickerEntity extends Equatable {
  final String symbol;
  final double price;

  const TickerEntity({required this.symbol, required this.price});

  @override
  List<Object?> get props => [symbol, price];
}
