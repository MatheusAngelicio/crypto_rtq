import 'package:crypto_rtq/domain/entities/ticker_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticker_event.dart';
import 'ticker_state.dart';
import '../../domain/usecases/get_prices_stream_usecase.dart';
import 'dart:async';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  final GetPriceStreamUseCase _getPriceStreamUseCase;

  final Map<String, StreamSubscription<TickerEntity>> _subscriptions = {};
  final Map<String, TickerEntity> _prices = {};

  TickerBloc(this._getPriceStreamUseCase) : super(TickerInitial()) {
    on<SubscribeToTickers>(_handleSubscribeToTickers);
    on<TickerUpdated>(_handleTickerUpdated);
    on<TickerErrorOccurred>(_handleTickerError);
  }

  Future<void> _handleSubscribeToTickers(
    SubscribeToTickers event,
    Emitter<TickerState> emit,
  ) async {
    emit(TickerLoading());
    await _cancelAllSubscriptions();

    for (final symbol in event.symbols) {
      final subscription = _getPriceStreamUseCase(symbol).listen(
        (ticker) {
          add(TickerUpdated(ticker));
        },
        onError: (error) {
          add(TickerErrorOccurred(error.toString()));
        },
      );

      _subscriptions[symbol] = subscription;
    }
  }

  void _handleTickerUpdated(TickerUpdated event, Emitter<TickerState> emit) {
    _prices[event.ticker.symbol] = event.ticker;

    emit(TickerLoaded(_prices.values.toList()));
  }

  void _handleTickerError(
    TickerErrorOccurred event,
    Emitter<TickerState> emit,
  ) {
    emit(TickerError(event.message));
  }

  Future<void> _cancelAllSubscriptions() async {
    for (final symbol in _subscriptions.keys) {
      await _subscriptions[symbol]?.cancel();
      _getPriceStreamUseCase.unsubscribe(symbol); // <- fecha o WebSocket também
    }

    _subscriptions.clear();
    _prices.clear();
  }

  @override
  Future<void> close() async {
    await _cancelAllSubscriptions();
    _getPriceStreamUseCase.dispose(); // <- fecha TODOS os canais ativos
    return super.close();
  }
}
