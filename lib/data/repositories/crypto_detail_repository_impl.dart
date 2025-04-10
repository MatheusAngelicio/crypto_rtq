import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/data/datasources/crypto/crypto_datasource.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:crypto_rtq/domain/repositories/crypto_detail_repository.dart';
import 'package:dartz/dartz.dart';

class CryptoDetailRepositoryImpl implements CryptoDetailRepository {
  final CryptoDetailDatasource datasource;

  CryptoDetailRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, CryptoDetailEntity>> call(String symbol) async {
    try {
      final result = await datasource(symbol);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
