import '../entities/ticker_entity.dart';
import '../repositories/ticker_repository.dart';

class GetPriceStreamUseCase {
  final TickerRepository repository;

  GetPriceStreamUseCase(this.repository);

  Stream<TickerEntity> call(String symbol) {
    return repository.subscribeTicker(symbol);
  }
}
