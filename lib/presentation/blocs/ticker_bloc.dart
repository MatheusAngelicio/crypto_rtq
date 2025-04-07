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
    on<LoadTickers>(_onLoadTickers);
    on<SubscribeToTicker>(_onSubscribeToTicker);
  }

  Future<void> _onLoadTickers(
    LoadTickers event,
    Emitter<TickerState> emit,
  ) async {
    emit(TickerLoading());
    try {
      final tickers = await getPrices();
      emit(TickerLoaded(tickers));
    } catch (e) {
      emit(TickerError('Failed to load tickers: $e'));
    }
  }

  void _onSubscribeToTicker(
    SubscribeToTicker event,
    Emitter<TickerState> emit,
  ) {
    subscribeTicker(event.symbol).listen((ticker) {
      // Aqui você pode emitir um novo estado ou atualizar um já existente.
      // Exemplo simplificado:
      emit(TickerLoaded([ticker]));
    });
  }
}
