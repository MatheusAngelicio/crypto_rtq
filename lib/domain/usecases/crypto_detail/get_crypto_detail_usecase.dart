import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GetCryptoDetailUseCase {
  Future<Either<Failure, CryptoDetailEntity>> call(String symbol);
}
