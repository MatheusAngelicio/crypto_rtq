import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoChartDataWidget extends StatelessWidget {
  const CryptoChartDataWidget({super.key, required this.chartData});

  final List<CryptoChartEntity> chartData;

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
        majorGridLines: const MajorGridLines(width: 0.5),
      ),
      series: <CartesianSeries>[
        LineSeries<CryptoChartEntity, DateTime>(
          dataSource: chartData,
          xValueMapper: (CryptoChartEntity data, _) => data.openTime,
          yValueMapper: (CryptoChartEntity data, _) => data.close,
          color: Colors.cyan,
          width: 2,
          markerSettings: const MarkerSettings(isVisible: false),
        ),
      ],
    );
  }
}
