import '../entities/ticker_entity.dart';

abstract interface class GetTickerPricesStreamRepository {
  Stream<TickerEntity> subscribeTicker(String symbol);

  void unsubscribe(String symbol);

  void dispose();
}
