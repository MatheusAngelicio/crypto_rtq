import '../../domain/entities/ticker_entity.dart';
import '../../domain/repositories/get_ticker_prices_stream_repository.dart';
import '../datasources/ticker/get_ticker_prices_stream_datasource.dart';

class GetTickerPricesStreamRepositoryImpl
    implements GetTickerPricesStreamRepository {
  GetTickerPricesStreamRepositoryImpl({
    required GetTickerPricesStreamDatasource datasource,
  }) : _datasource = datasource;

  final GetTickerPricesStreamDatasource _datasource;

  @override
  Stream<TickerEntity> subscribeTicker(String symbol) {
    return _datasource.connect(symbol);
  }

  @override
  void unsubscribe(String symbol) {
    _datasource.unsubscribe(symbol);
  }

  @override
  void dispose() {
    _datasource.dispose();
  }
}
