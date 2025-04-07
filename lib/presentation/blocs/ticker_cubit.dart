import 'package:crypto_rtq/domain/entities/ticker_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticker_state.dart';
import '../../domain/usecases/get_prices_stream_usecase.dart';
import 'dart:async';

class TickerCubit extends Cubit<TickerState> {
  final GetPriceStreamUseCase _getPriceStreamUseCase;

  final Map<String, StreamSubscription<TickerEntity>> _subscriptions = {};
  final Map<String, TickerEntity> _prices = {};

  TickerCubit(this._getPriceStreamUseCase) : super(TickerInitial());

  void load(List<String> symbols) async {
    emit(TickerLoading());
    await _cancelAllSubscriptions();

    for (final symbol in symbols) {
      final subscription = _getPriceStreamUseCase(symbol).listen(
        (ticker) {
          _prices[ticker.symbol] = ticker;
          emit(TickerLoaded(_prices.values.toList()));
        },
        onError: (error) {
          emit(TickerError(error.toString()));
        },
      );

      _subscriptions[symbol] = subscription;
    }
  }

  Future<void> _cancelAllSubscriptions() async {
    for (final symbol in _subscriptions.keys) {
      await _subscriptions[symbol]?.cancel();
      _getPriceStreamUseCase.unsubscribe(symbol);
    }

    _subscriptions.clear();
    _prices.clear();
  }

  @override
  Future<void> close() async {
    await _cancelAllSubscriptions();
    _getPriceStreamUseCase.dispose();
    return super.close();
  }
}
