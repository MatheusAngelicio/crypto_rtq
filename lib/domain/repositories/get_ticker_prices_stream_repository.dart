import '../entities/ticker_entity.dart';

abstract class GetTickerPricesStreamRepository {
  Stream<TickerEntity> subscribeTicker(String symbol);

  void unsubscribe(String symbol);

  void dispose();
}
