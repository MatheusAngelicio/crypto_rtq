import 'package:crypto_rtq/core/constants/api_endpoints.dart';
import 'package:crypto_rtq/core/exception/crypto_exception.dart';
import 'package:crypto_rtq/core/network/dio_client.dart';
import 'package:crypto_rtq/core/utils/app_logger.dart';
import 'package:crypto_rtq/data/datasources/exchange_rate/get_exchange_rate_datasource.dart';
import 'package:crypto_rtq/data/models/exchange_rate_model.dart';

class GetExchangeRateDatasourceImpl implements GetExchangeRateDatasource {
  GetExchangeRateDatasourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  final DioClient _dioClient;

  @override
  Future<ExchangeRateModel> getQuote(String symbol) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.tickerPrice,
        queryParameters: {'symbol': symbol},
      );

      if (response.statusCode == 200 && response.data != null) {
        return ExchangeRateModel.fromMap(response.data);
      } else {
        AppLogger.error(
          '[Datasource] Unexpected exchange rate response: ${response.statusCode} - ${response.data}',
        );
        throw CryptoException('Invalid response from server.');
      }
    } catch (e) {
      AppLogger.error('[Datasource] Error fetching exchange rate: $e');
      throw CryptoException(e.toString());
    }
  }
}
