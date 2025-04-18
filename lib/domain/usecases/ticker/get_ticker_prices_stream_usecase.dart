import '../../entities/ticker_entity.dart';

abstract interface class GetTickerPricesStreamUsecase {
  Stream<TickerEntity> call(String symbol);
  void unsubscribe(String symbol);
  void dispose();
}
