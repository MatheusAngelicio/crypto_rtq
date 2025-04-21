import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';
import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:crypto_rtq/domain/repositories/get_crypto_details_repository.dart';
import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_details_usecase.dart';
import 'package:dartz/dartz.dart';

class GetCryptoDetaislUseCaseImpl implements GetCryptoDetailsUseCase {
  GetCryptoDetaislUseCaseImpl({required GetCryptoDetailsRepository repository})
    : _repository = repository;

  final GetCryptoDetailsRepository _repository;

  @override
  Future<Either<Failure, CryptoDetailEntity>> getDetail(String symbol) {
    return _repository.getDetail(symbol);
  }

  @override
  Future<Either<Failure, List<CryptoChartEntity>>> getChartData(
    String symbol,
    ChartIntervalEnum interval,
  ) {
    return _repository.getChartData(symbol, interval);
  }
}
