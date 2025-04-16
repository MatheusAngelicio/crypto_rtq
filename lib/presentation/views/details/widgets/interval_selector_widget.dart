import 'package:flutter/material.dart';

class IntervalSelectorWidget extends StatelessWidget {
  final String selectedInterval;
  final ValueChanged<String> onIntervalSelected;

  const IntervalSelectorWidget({
    super.key,
    required this.selectedInterval,
    required this.onIntervalSelected,
  });

  @override
  Widget build(BuildContext context) {
    final intervals = ['1h', '1d', '1w', '1m'];
    final labels = ['1H', '1D', '1S', '1M'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(intervals.length, (index) {
        final interval = intervals[index];
        final label = labels[index];

        final isSelected = selectedInterval == interval;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.black : Colors.grey[300],
            foregroundColor: isSelected ? Colors.white : Colors.black,
          ),
          onPressed: () => onIntervalSelected(interval),
          child: Text(label),
        );
      }),
    );
  }
}
