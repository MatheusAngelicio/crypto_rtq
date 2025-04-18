import '../../models/ticker_model.dart';

abstract class GetTickerPricesStreamDatasource {
  Stream<TickerModel> connect(String symbol);
  void unsubscribe(String symbol);
  void dispose();
}
