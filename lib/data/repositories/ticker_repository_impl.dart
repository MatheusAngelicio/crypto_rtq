import '../../domain/entities/ticker_entity.dart';
import '../../domain/repositories/ticker_repository.dart';
import '../datasources/ticker/ticker_stream_datasource.dart';

class TickerRepositoryImpl implements TickerRepository {
  final TickerStreamDatasource datasource;

  TickerRepositoryImpl({required this.datasource});

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
