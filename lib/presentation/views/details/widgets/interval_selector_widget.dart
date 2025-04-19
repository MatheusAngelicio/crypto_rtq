import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';
import 'package:crypto_rtq/core/extensions/chart_interval_extension.dart';
import 'package:flutter/material.dart';

class IntervalSelectorWidget extends StatelessWidget {
  final ChartIntervalEnum selectedInterval;
  final ValueChanged<ChartIntervalEnum> onIntervalSelected;

  const IntervalSelectorWidget({
    super.key,
    required this.selectedInterval,
    required this.onIntervalSelected,
  });

  @override
  Widget build(BuildContext context) {
    final intervals = [
      ChartIntervalEnum.hour1,
      ChartIntervalEnum.day1,
      ChartIntervalEnum.week1,
      ChartIntervalEnum.month1,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          intervals.map((interval) {
            final isSelected = selectedInterval == interval;

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.white : Colors.black,
                foregroundColor: isSelected ? Colors.black : Colors.grey[300],
              ),
              onPressed: () => onIntervalSelected(interval),
              child: Text(interval.label),
            );
          }).toList(),
    );
  }
}
