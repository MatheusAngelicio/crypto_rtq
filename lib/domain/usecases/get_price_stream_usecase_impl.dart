import 'package:crypto_rtq/domain/entities/ticker_entity.dart';
import 'package:crypto_rtq/domain/repositories/ticker_repository.dart';
import 'package:crypto_rtq/domain/usecases/get_prices_stream_usecase.dart';

class GetPriceStreamUseCaseImpl implements GetPriceStreamUseCase {
  final TickerRepository repository;

  GetPriceStreamUseCaseImpl({required this.repository});

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
