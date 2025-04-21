import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';
import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/data/datasources/crypto/get_crypto_details_datasource.dart';
import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:crypto_rtq/domain/repositories/get_crypto_details_repository.dart';
import 'package:dartz/dartz.dart';

class GetCryptoDetailsRepositoryImpl implements GetCryptoDetailsRepository {
  GetCryptoDetailsRepositoryImpl({
    required GetCryptoDetailsDatasource datasource,
  }) : _datasource = datasource;

  final GetCryptoDetailsDatasource _datasource;

  @override
  Future<Either<Failure, CryptoDetailEntity>> getDetail(String symbol) async {
    try {
      final result = await _datasource.getDetail(symbol);
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
    ChartIntervalEnum interval,
  ) async {
    try {
      final result = await _datasource.getChartData(symbol, interval);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Error fetching chart data: ${e.toString()}'));
    }
  }
}
