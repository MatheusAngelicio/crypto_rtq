import 'package:equatable/equatable.dart';

class CryptoChartEntity extends Equatable {
  final DateTime openTime;
  final double open;
  final double high;
  final double low;
  final double close;

  const CryptoChartEntity({
    required this.openTime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  @override
  List<Object?> get props => [openTime, open, high, low, close];
}
