import 'package:flutter/material.dart';

class CurrencyToggleWidget extends StatelessWidget {
  const CurrencyToggleWidget({
    super.key,
    required this.isBRL,
    required this.onChanged,
  });

  final bool isBRL;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('USD'),
          Switch(value: isBRL, onChanged: onChanged),
          const Text('BRL'),
        ],
      ),
    );
  }
}
