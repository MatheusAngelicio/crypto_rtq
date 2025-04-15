import 'package:crypto_rtq/core/utils/currency_util.dart';
import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoChartDataWidget extends StatelessWidget {
  const CryptoChartDataWidget({
    super.key,
    required this.chartData,
    required this.isBRL,
  });

  final List<CryptoChartEntity> chartData;
  final bool isBRL;

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.minutes,
        dateFormat: DateFormat.Hm(),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.currency(
          locale: isBRL ? 'pt_BR' : 'en_US',
          symbol: isBRL ? 'R\$' : '\$ ',
          decimalDigits: 2,
        ),
        majorGridLines: const MajorGridLines(width: 0.5),
      ),
      series: <CartesianSeries>[
        LineSeries<CryptoChartEntity, DateTime>(
          dataSource: chartData,
          xValueMapper: (CryptoChartEntity data, _) => data.openTime,
          yValueMapper:
              (CryptoChartEntity data, _) =>
                  CurrencyUtils.convert(data.close, toBRL: isBRL),
          color: Colors.cyan,
          width: 2,
          markerSettings: const MarkerSettings(isVisible: false),
        ),
      ],
    );
  }
}
