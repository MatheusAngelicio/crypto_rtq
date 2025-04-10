import 'package:crypto_rtq/core/network/dio_client.dart';
import 'package:crypto_rtq/core/utils/app_logger.dart';
import 'package:crypto_rtq/data/datasources/crypto/crypto_datasource.dart';
import 'package:crypto_rtq/data/models/crypto_detail_model.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';

class CryptoDetailDatasourceImpl implements CryptoDetailDatasource {
  final DioClient dioClient;

  CryptoDetailDatasourceImpl({required this.dioClient});

  @override
  Future<CryptoDetailEntity> call(String symbol) async {
    try {
      final response = await dioClient.dio.get(
        '/ticker/24hr',
        queryParameters: {'symbol': symbol},
      );

      final data = response.data;
      return CryptoDetailModel.fromJson(data).toEntity();
    } catch (e) {
      AppLogger.error('[Datasource] Error fetching crypto detail: $e');
      throw Exception('Datasource error: $e');
    }
  }
}
