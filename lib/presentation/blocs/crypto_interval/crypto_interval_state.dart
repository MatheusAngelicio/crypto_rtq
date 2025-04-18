import 'package:crypto_rtq/core/enums/chart_inverval.dart';

class CryptoIntervalState {
  final ChartInterval interval;
  final int limit;

  const CryptoIntervalState({required this.interval, required this.limit});

  CryptoIntervalState copyWith({ChartInterval? interval, int? limit}) {
    return CryptoIntervalState(
      interval: interval ?? this.interval,
      limit: limit ?? this.limit,
    );
  }
}
