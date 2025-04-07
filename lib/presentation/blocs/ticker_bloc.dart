import 'package:crypto_rtq/domain/entities/ticker_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ticker_event.dart';
import 'ticker_state.dart';
import '../../../domain/usecases/get_prices_usecase.dart';
import '../../../domain/usecases/subscribe_ticker_usecase.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  final GetPricesUseCase getPrices;
  final SubscribeTickerUseCase subscribeTicker;

  TickerBloc({required this.getPrices, required this.subscribeTicker})
    : super(TickerInitial()) {
    on<GetPricesEvent>(_onGetPrices);
    on<SubscribeTickerEvent>(_onSubscribeTicker);
  }

  Future<void> _onGetPrices(
    GetPricesEvent event,
    Emitter<TickerState> emit,
  ) async {
    emit(TickerLoading());
    try {
      final tickers = await getPrices(event.symbols);
      emit(TickerLoaded(tickers));
    } catch (e) {
      emit(TickerError('Failed to load tickers: $e'));
    }
  }

  void _onSubscribeTicker(
    SubscribeTickerEvent event,
    Emitter<TickerState> emit,
  ) {
    // Inicializa a lista atual com o estado atual, se for TickerLoaded
    List<TickerEntity> currentTickers = [];
    if (state is TickerLoaded) {
      currentTickers = List.from((state as TickerLoaded).tickers);
    }

    for (final symbol in event.symbols) {
      subscribeTicker(symbol).listen((ticker) {
        // Atualiza ou adiciona o ticker recebido
        final index = currentTickers.indexWhere(
          (t) => t.symbol == ticker.symbol,
        );
        if (index >= 0) {
          currentTickers[index] = ticker;
        } else {
          currentTickers.add(ticker);
        }

        emit(
          TickerLoaded(List.from(currentTickers)),
        ); // emite a lista atualizada
      });
    }
  }
}
