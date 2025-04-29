import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/presentation/cubits/crypto_notifications/crypto_notifications_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoNotificationsCubit extends Cubit<CryptoNotificationsState> {
  CryptoNotificationsCubit()
    : super(CryptoNotificationsState(minControllers: {}, maxControllers: {})) {
    _initializeControllers();
  }

  void _initializeControllers() {
    final min = <String, TextEditingController>{};
    final max = <String, TextEditingController>{};

    for (var crypto in TickerUtils.names) {
      min[crypto] = TextEditingController();
      max[crypto] = TextEditingController();
    }

    emit(CryptoNotificationsState(minControllers: min, maxControllers: max));
  }

  @override
  Future<void> close() {
    for (var controller in state.minControllers.values) {
      controller.dispose();
    }
    for (var controller in state.maxControllers.values) {
      controller.dispose();
    }
    return super.close();
  }
}
