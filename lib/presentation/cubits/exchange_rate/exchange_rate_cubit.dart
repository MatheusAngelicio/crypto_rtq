import 'package:crypto_rtq/domain/usecases/exchange_rate/get_exchange_rate_usecase.dart';
import 'package:crypto_rtq/presentation/cubits/exchange_rate/exchange_rate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final GetExchangeRateUsecase _getExchangeRateUsecase;

  ExchangeRateCubit({required GetExchangeRateUsecase getExchangeRateUsecase})
    : _getExchangeRateUsecase = getExchangeRateUsecase,
      super(ExchangeRateInitial());

  Future<void> load(String symbol) async {
    emit(ExchangeRateLoading());

    final result = await _getExchangeRateUsecase.getQuote(symbol);

    result.fold(
      (failure) => emit(ExchangeRateError(failure.message)),
      (entity) => emit(ExchangeRateLoaded(entity)),
    );
  }
}
