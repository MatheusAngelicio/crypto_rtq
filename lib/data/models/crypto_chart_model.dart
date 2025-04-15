import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';

class CryptoChartModel {
  final DateTime openTime;
  final double open;
  final double high;
  final double low;
  final double close;

  CryptoChartModel({
    required this.openTime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory CryptoChartModel.fromJson(List<dynamic> json) {
    return CryptoChartModel(
      openTime: DateTime.fromMillisecondsSinceEpoch(json[0]),
      open: double.parse(json[1]),
      high: double.parse(json[2]),
      low: double.parse(json[3]),
      close: double.parse(json[4]),
    );
  }

  CryptoChartEntity toEntity() {
    return CryptoChartEntity(
      openTime: openTime,
      open: open,
      high: high,
      low: low,
      close: close,
    );
  }
}
