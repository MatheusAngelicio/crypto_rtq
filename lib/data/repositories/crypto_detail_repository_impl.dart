import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/data/datasources/crypto/crypto_datasource.dart';
import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:crypto_rtq/domain/repositories/crypto_detail_repository.dart';
import 'package:dartz/dartz.dart';

class CryptoDetailRepositoryImpl implements CryptoDetailRepository {
  final CryptoDetailDatasource datasource;

  CryptoDetailRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, CryptoDetailEntity>> getDetail(String symbol) async {
    try {
      final result = await datasource.getDetail(symbol);
      return Right(result);
    } catch (e) {
      return Left(
        ServerFailure('Error fetching crypto detail: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<CryptoChartEntity>>> getChartData(
    String symbol,
    String interval,
    int limit,
  ) async {
    try {
      final result = await datasource.getChartData(symbol, interval, limit);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Error fetching chart data: ${e.toString()}'));
    }
  }
}
