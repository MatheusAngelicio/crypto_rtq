import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';
import 'package:crypto_rtq/data/models/crypto_chart_model.dart';
import 'package:crypto_rtq/data/models/crypto_detail_model.dart';

abstract interface class GetCryptoDetailsDatasource {
  Future<CryptoDetailModel> getDetail(String symbol);

  Future<List<CryptoChartModel>> getChartData(
    String symbol,
    ChartIntervalEnum interval,
  );
}
