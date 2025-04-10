import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';

abstract class CryptoDetailDatasource {
  Future<CryptoDetailEntity> call(String symbol);
}
