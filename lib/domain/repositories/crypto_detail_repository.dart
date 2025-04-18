import 'package:crypto_rtq/core/enums/chart_inverval.dart';
import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CryptoDetailRepository {
  Future<Either<Failure, CryptoDetailEntity>> getDetail(String symbol);
  Future<Either<Failure, List<CryptoChartEntity>>> getChartData(
    String symbol,
    ChartInterval interval,
    int limit,
  );
}
