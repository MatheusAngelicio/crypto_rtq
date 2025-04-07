import '../entities/ticker_entity.dart';
import '../repositories/ticker_repository.dart';

class GetPricesUseCase {
  final TickerRepository repository;

  GetPricesUseCase(this.repository);

  Future<List<TickerEntity>> call() {
    return repository.getPrices();
  }
}
