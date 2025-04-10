import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:crypto_rtq/domain/repositories/crypto_detail_repository.dart';
import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_detail_usecase.dart';
import 'package:dartz/dartz.dart';

class GetCryptoDetailUseCaseImpl implements GetCryptoDetailUseCase {
  final CryptoDetailRepository repository;

  GetCryptoDetailUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, CryptoDetailEntity>> call(String symbol) {
    return repository(symbol);
  }
}
