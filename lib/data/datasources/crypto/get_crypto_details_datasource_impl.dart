import 'package:crypto_rtq/core/constants/api_endpoints.dart';
import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';
import 'package:crypto_rtq/core/exception/crypto_exception.dart';
import 'package:crypto_rtq/core/extensions/chart_interval_extension.dart';
import 'package:crypto_rtq/core/network/dio_client.dart';
import 'package:crypto_rtq/core/utils/app_logger.dart';
import 'package:crypto_rtq/data/datasources/crypto/get_crypto_details_datasource.dart';
import 'package:crypto_rtq/data/models/crypto_chart_model.dart';
import 'package:crypto_rtq/data/models/crypto_detail_model.dart';
import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';

class GetCryptoDetailsDatasourceImpl implements GetCryptoDetailsDatasource {
  GetCryptoDetailsDatasourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  final DioClient _dioClient;

  @override
  Future<CryptoDetailEntity> getDetail(String symbol) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.tickerDetail,
        queryParameters: {'symbol': symbol},
      );

      if (response.statusCode == 200 && response.data != null) {
        return CryptoDetailModel.fromMap(response.data);
      } else {
        AppLogger.error(
          '[Datasource] Unexpected response: ${response.statusCode} - ${response.data}',
        );
        throw CryptoException('Invalid response from server.');
      }
    } catch (e) {
      AppLogger.error('[Datasource] Error fetching crypto detail: $e');
      throw CryptoException(e.toString());
    }
  }

  @override
  Future<List<CryptoChartEntity>> getChartData(
    String symbol,
    ChartIntervalEnum interval,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.chartData,
        queryParameters: {
          'symbol': symbol,
          'interval': interval.apiValue,
          'startTime': interval.startTime.millisecondsSinceEpoch,
          'endTime': interval.endTime.millisecondsSinceEpoch,
          'timeZone': '0',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as List;
        return data.map((item) => CryptoChartModel.fromMap(item)).toList();
      } else {
        AppLogger.error(
          '[Datasource] Unexpected chart response: ${response.statusCode} - ${response.data}',
        );
        throw CryptoException('Invalid chart response from server.');
      }
    } catch (e) {
      AppLogger.error('[Datasource] Error fetching crypto chart data: $e');
      throw CryptoException('Failed to load chart data: $e');
    }
  }
}
