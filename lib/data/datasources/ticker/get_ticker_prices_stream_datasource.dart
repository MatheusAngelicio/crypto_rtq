import '../../models/ticker_model.dart';

abstract interface class GetTickerPricesStreamDatasource {
  Stream<TickerModel> connect(String symbol);
  void unsubscribe(String symbol);
  void dispose();
}
