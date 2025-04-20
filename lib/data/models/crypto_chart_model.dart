import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';

class CryptoChartModel extends CryptoChartEntity {
  const CryptoChartModel({
    required super.openTime,
    required super.open,
    required super.high,
    required super.low,
    required super.close,
  });

  factory CryptoChartModel.fromMap(List<dynamic> map) {
    return CryptoChartModel(
      openTime: DateTime.fromMillisecondsSinceEpoch(map[0]),
      open: double.parse(map[1]),
      high: double.parse(map[2]),
      low: double.parse(map[3]),
      close: double.parse(map[4]),
    );
  }

  List<dynamic> toMap() {
    return [
      openTime.millisecondsSinceEpoch,
      open.toString(),
      high.toString(),
      low.toString(),
      close.toString(),
    ];
  }
}
