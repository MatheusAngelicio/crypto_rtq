import 'package:crypto_rtq/data/models/exchange_rate_model.dart';

abstract interface class GetExchangeRateDatasource {
  Future<ExchangeRateModel> getQuote(String symbol);
}
