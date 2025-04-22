import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';

class CryptoIntervalState {
  final ChartIntervalEnum interval;

  const CryptoIntervalState({required this.interval});

  CryptoIntervalState copyWith({ChartIntervalEnum? interval, int? limit}) {
    return CryptoIntervalState(interval: interval ?? this.interval);
  }
}
