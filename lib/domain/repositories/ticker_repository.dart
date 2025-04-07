import '../entities/ticker_entity.dart';

abstract class TickerRepository {
  Stream<TickerEntity> subscribeTicker(String symbol);
}
