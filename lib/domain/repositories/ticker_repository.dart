import '../entities/ticker_entity.dart';

abstract class TickerRepository {
  Future<List<TickerEntity>> getPrices();
  Stream<TickerEntity> subscribeTicker(String symbol);
}
