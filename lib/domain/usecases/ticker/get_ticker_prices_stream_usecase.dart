import '../../entities/ticker_entity.dart';

abstract class GetTickerPricesStreamUsecase {
  Stream<TickerEntity> call(String symbol);
  void unsubscribe(String symbol);
  void dispose();
}
