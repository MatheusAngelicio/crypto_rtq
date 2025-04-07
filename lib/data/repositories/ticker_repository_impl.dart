import '../../domain/entities/ticker_entity.dart';
import '../../domain/repositories/ticker_repository.dart';
import '../datasources/ticker_stream_datasource.dart';

class TickerRepositoryImpl implements TickerRepository {
  final TickerStreamDatasource streamDatasource;

  TickerRepositoryImpl({required this.streamDatasource});

  @override
  Stream<TickerEntity> subscribeTicker(String symbol) {
    return streamDatasource.connect(symbol);
  }
}
