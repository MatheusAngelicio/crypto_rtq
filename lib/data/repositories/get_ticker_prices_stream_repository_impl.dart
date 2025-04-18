import '../../domain/entities/ticker_entity.dart';
import '../../domain/repositories/get_ticker_prices_stream_repository.dart';
import '../datasources/ticker/get_ticker_prices_stream_datasource.dart';

class GetTickerPricesStreamRepositoryImpl
    implements GetTickerPricesStreamRepository {
  final GetTickerPricesStreamDatasource datasource;

  GetTickerPricesStreamRepositoryImpl({required this.datasource});

  @override
  Stream<TickerEntity> subscribeTicker(String symbol) {
    return datasource.connect(symbol);
  }

  @override
  void unsubscribe(String symbol) {
    datasource.unsubscribe(symbol);
  }

  @override
  void dispose() {
    datasource.dispose();
  }
}
