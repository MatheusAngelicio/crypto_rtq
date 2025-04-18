import 'package:crypto_rtq/core/enums/chart_inverval.dart';
import 'package:flutter/material.dart';

class IntervalSelectorWidget extends StatelessWidget {
  final ChartInterval selectedInterval;
  final ValueChanged<ChartInterval> onIntervalSelected;

  const IntervalSelectorWidget({
    super.key,
    required this.selectedInterval,
    required this.onIntervalSelected,
  });

  @override
  Widget build(BuildContext context) {
    final intervals = [
      ChartInterval.hour1,
      ChartInterval.day1,
      ChartInterval.week1,
      ChartInterval.month1,
    ];

    final labels = ['1H', '1D', '1W', '1M'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(intervals.length, (index) {
        final interval = intervals[index];
        final label = labels[index];

        final isSelected = selectedInterval == interval;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.white : Colors.black,
            foregroundColor: isSelected ? Colors.black : Colors.grey[300],
          ),
          onPressed: () => onIntervalSelected(interval),
          child: Text(label),
        );
      }),
    );
  }
}
