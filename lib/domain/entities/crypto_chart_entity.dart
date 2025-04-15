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

  static double getTimeInterval(List<CryptoChartEntity> data) {
    if (data.length < 2) return 1;
    final diff = data[1].openTime.difference(data[0].openTime).inMinutes;
    return diff * 60 * 1000;
  }

  @override
  List<Object?> get props => [openTime, open, high, low, close];
}
