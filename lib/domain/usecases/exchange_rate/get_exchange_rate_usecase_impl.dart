import 'package:crypto_rtq/core/errors/failure.dart';
import 'package:crypto_rtq/core/services/app_rates.dart';
import 'package:crypto_rtq/domain/entities/exchange_rate_entity.dart';
import 'package:crypto_rtq/domain/repositories/get_exchange_rate_repository.dart';
import 'package:crypto_rtq/domain/usecases/exchange_rate/get_exchange_rate_usecase.dart';
import 'package:dartz/dartz.dart';

class GetExchangeRateUsecaseImpl implements GetExchangeRateUsecase {
  GetExchangeRateUsecaseImpl({required GetExchangeRateRepository repository})
    : _repository = repository;

  final GetExchangeRateRepository _repository;

  @override
  Future<Either<Failure, ExchangeRateEntity>> getQuote(String symbol) async {
    final result = await _repository.getQuote(symbol);

    result.fold((failure) => null, (exchangeRate) {
      final rate = double.tryParse(exchangeRate.price);
      AppRates.updateUsdBrl(rate);
    });

    return result;
  }
}
