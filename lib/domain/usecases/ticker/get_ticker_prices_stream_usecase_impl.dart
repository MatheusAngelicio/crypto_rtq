import 'package:crypto_rtq/domain/entities/ticker_entity.dart';
import 'package:crypto_rtq/domain/repositories/get_ticker_prices_stream_repository.dart';
import 'package:crypto_rtq/domain/usecases/ticker/get_ticker_prices_stream_usecase.dart';

class GetTickerPricesStreamUsecaseImpl implements GetTickerPricesStreamUsecase {
  final GetTickerPricesStreamRepository repository;

  GetTickerPricesStreamUsecaseImpl({required this.repository});

  @override
  Stream<TickerEntity> call(String symbol) {
    return repository.subscribeTicker(symbol);
  }

  @override
  void unsubscribe(String symbol) {
    repository.unsubscribe(symbol);
  }

  @override
  void dispose() {
    repository.dispose();
  }
}
