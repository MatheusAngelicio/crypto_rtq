import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';
import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';

abstract interface class GetCryptoDetailsDatasource {
  Future<CryptoDetailEntity> getDetail(String symbol);

  Future<List<CryptoChartEntity>> getChartData(
    String symbol,
    ChartIntervalEnum interval,
  );
}
