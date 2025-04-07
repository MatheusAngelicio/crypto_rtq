import '../../domain/entities/ticker_entity.dart';
import '../../domain/repositories/ticker_repository.dart';
import '../datasources/binance_datasource.dart';

class TickerRepositoryImpl implements TickerRepository {
  final BinanceDatasource datasource;

  TickerRepositoryImpl(this.datasource);

  @override
  Future<List<TickerEntity>> getPrices() {
    return datasource.getPrices();
  }

  @override
  Stream<TickerEntity> subscribeTicker(String symbol) {
    return datasource.subscribeTicker(symbol);
  }
}
