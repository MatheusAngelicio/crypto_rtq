import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/data/datasources/exchange_rate/get_exchange_rate_datasource.dart';
import 'package:crypto_rtq/domain/entities/exchange_rate_entity.dart';
import 'package:crypto_rtq/domain/repositories/get_exchange_rate_repository.dart';
import 'package:dartz/dartz.dart';

class GetExchangeRateRepositoryImpl implements GetExchangeRateRepository {
  GetExchangeRateRepositoryImpl({required GetExchangeRateDatasource datasource})
    : _datasource = datasource;

  final GetExchangeRateDatasource _datasource;

  @override
  Future<Either<Failure, ExchangeRateEntity>> getQuote(String symbol) async {
    try {
      final result = await _datasource.getQuote(symbol);
      return Right(result);
    } catch (e) {
      return Left(
        ServerFailure('Error fetching exchange rate: ${e.toString()}'),
      );
    }
  }
}
