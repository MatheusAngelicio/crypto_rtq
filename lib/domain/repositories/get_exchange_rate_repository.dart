import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/domain/entities/exchange_rate_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class GetExchangeRateRepository {
  Future<Either<Failure, ExchangeRateEntity>> getQuote(String symbol);
}
