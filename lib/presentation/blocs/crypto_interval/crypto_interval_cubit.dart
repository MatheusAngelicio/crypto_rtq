import 'package:crypto_rtq/core/enums/chart_inverval.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'crypto_interval_state.dart';

class CryptoIntervalCubit extends Cubit<CryptoIntervalState> {
  static const ChartInterval _defaultInterval = ChartInterval.hour1;
  static const int _defaultLimit = 30;

  CryptoIntervalCubit()
    : super(
        const CryptoIntervalState(
          interval: _defaultInterval,
          limit: _defaultLimit,
        ),
      );

  void selectInterval(ChartInterval interval) {
    final limit = _getLimitByInterval(interval);
    emit(state.copyWith(interval: interval, limit: limit));
  }

  void reset() {
    emit(
      const CryptoIntervalState(
        interval: _defaultInterval,
        limit: _defaultLimit,
      ),
    );
  }

  // Tirar essa lógica do cubit depois
  int _getLimitByInterval(ChartInterval interval) {
    switch (interval) {
      case ChartInterval.hour1:
        return 30;
      case ChartInterval.day1:
        return 24;
      case ChartInterval.second1:
        return 7;
      case ChartInterval.minute1:
        return 30;
      default:
        return 30;
    }
  }
}
