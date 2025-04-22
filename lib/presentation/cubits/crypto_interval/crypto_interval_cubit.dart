import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'crypto_interval_state.dart';

class CryptoIntervalCubit extends Cubit<CryptoIntervalState> {
  static const ChartIntervalEnum _defaultInterval = ChartIntervalEnum.hour1;

  CryptoIntervalCubit()
    : super(const CryptoIntervalState(interval: _defaultInterval));

  void selectInterval(ChartIntervalEnum interval) {
    emit(CryptoIntervalState(interval: interval));
  }

  void reset() {
    emit(const CryptoIntervalState(interval: _defaultInterval));
  }
}
