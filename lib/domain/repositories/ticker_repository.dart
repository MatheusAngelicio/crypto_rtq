import '../entities/ticker_entity.dart';

abstract class TickerRepository {
  Future<List<TickerEntity>> getPrices(List<String> symbols);
  Stream<TickerEntity> subscribeTicker(String symbol);
}
