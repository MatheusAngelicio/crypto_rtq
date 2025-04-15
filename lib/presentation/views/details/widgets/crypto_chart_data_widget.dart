import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CryptoChartDataWidget extends StatelessWidget {
  const CryptoChartDataWidget({super.key, required this.chartData});

  final List<CryptoChartEntity> chartData;

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return const Center(child: Text('No data available'));
    }
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots:
                chartData
                    .map(
                      (e) => FlSpot(
                        e.openTime.millisecondsSinceEpoch.toDouble(),
                        e.close,
                      ),
                    )
                    .toList(),
            isCurved: true,
            color: Colors.cyan,
            barWidth: 2,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: CryptoChartEntity.getTimeInterval(chartData),
              getTitlesWidget: (value, meta) {
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                return Text(
                  '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
      ),
    );
  }
}
