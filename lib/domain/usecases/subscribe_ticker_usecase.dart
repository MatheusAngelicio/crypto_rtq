import '../entities/ticker_entity.dart';
import '../repositories/ticker_repository.dart';

class SubscribeTickerUseCase {
  final TickerRepository repository;

  SubscribeTickerUseCase(this.repository);

  Stream<TickerEntity> call(String symbol) {
    return repository.subscribeTicker(symbol);
  }
}
