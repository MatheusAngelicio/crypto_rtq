import 'package:crypto_rtq/domain/entities/ticker_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticker_state.dart';
import '../../../domain/usecases/ticker/get_prices_stream_usecase.dart';
import 'dart:async';

class TickerCubit extends Cubit<TickerState> {
  TickerCubit(this._getPriceStreamUseCase) : super(TickerInitial());

  final GetPriceStreamUseCase _getPriceStreamUseCase;
  final Map<String, StreamSubscription<TickerEntity>> _subscriptions = {};
  final Map<String, TickerEntity> _prices = {};
  String _currency = 'USD';

  void load(List<String> symbols) async {
    emit(TickerLoading());
    await _cancelAllSubscriptions();

    for (final symbol in symbols) {
      final subscription = _getPriceStreamUseCase(symbol).listen(
        (ticker) {
          _prices[ticker.symbol] = ticker;
          _emitSortedPricesIfReady(expectedCount: symbols.length);
        },
        onError: (error) {
          emit(TickerError(error.toString()));
        },
      );

      _subscriptions[symbol] = subscription;
    }
  }

  void _emitSortedPricesIfReady({required int expectedCount}) {
    if (_prices.length < expectedCount) return;

    final sortedPrices =
        _prices.values.toList()..sort((a, b) => b.price.compareTo(a.price));

    emit(TickerLoaded(sortedPrices, currency: _currency));
  }

  void toggleCurrency() {
    _currency = _currency == 'USD' ? 'BRL' : 'USD';

    final sortedPrices =
        _prices.values.toList()..sort((a, b) => b.price.compareTo(a.price));

    emit(TickerLoaded(sortedPrices, currency: _currency));
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
