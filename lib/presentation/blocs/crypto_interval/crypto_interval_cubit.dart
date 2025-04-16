import 'package:flutter_bloc/flutter_bloc.dart';
import 'crypto_interval_state.dart';

class CryptoIntervalCubit extends Cubit<CryptoIntervalState> {
  static const String _defaultInterval = '1h';
  static const int _defaultLimit = 30;

  CryptoIntervalCubit()
    : super(
        const CryptoIntervalState(
          interval: _defaultInterval,
          limit: _defaultLimit,
        ),
      );

  void selectInterval(String interval) {
    int limit = _getLimitByInterval(interval);
    emit(state.copyWith(interval: interval, limit: limit));
  }

  int _getLimitByInterval(String interval) {
    switch (interval) {
      case '1h':
        return 30;
      case '1d':
        return 24;
      case '1s':
        return 7;
      case '1m':
        return 30;
      default:
        return 30;
    }
  }

  void reset() {
    emit(CryptoIntervalState(interval: _defaultInterval, limit: _defaultLimit));
  }
}
