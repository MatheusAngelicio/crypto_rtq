import 'package:crypto_rtq/domain/entities/ticker_entity.dart';
import 'package:crypto_rtq/domain/repositories/get_ticker_prices_stream_repository.dart';
import 'package:crypto_rtq/domain/usecases/ticker/get_ticker_prices_stream_usecase.dart';

class GetTickerPricesStreamUsecaseImpl implements GetTickerPricesStreamUsecase {
  GetTickerPricesStreamUsecaseImpl({
    required GetTickerPricesStreamRepository repository,
  }) : _repository = repository;

  final GetTickerPricesStreamRepository _repository;

  @override
  Stream<TickerEntity> call(String symbol) {
    return _repository.subscribeTicker(symbol);
  }

  @override
  void unsubscribe(String symbol) {
    _repository.unsubscribe(symbol);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
