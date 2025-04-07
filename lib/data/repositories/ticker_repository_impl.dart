import '../../domain/entities/ticker_entity.dart';
import '../../domain/repositories/ticker_repository.dart';
import '../datasources/binance_datasource.dart';

class TickerRepositoryImpl implements TickerRepository {
  final BinanceDatasource datasource;

  TickerRepositoryImpl(this.datasource);

  @override
  Future<List<TickerEntity>> getPrices(List<String> symbols) async {
    final allTickers = await datasource.getPrices();
    return allTickers
        .where((t) => symbols.contains(t.symbol.toUpperCase()))
        .toList();
  }

  @override
  Stream<TickerEntity> subscribeTicker(String symbol) {
    return datasource.subscribeTicker(symbol);
  }
}
