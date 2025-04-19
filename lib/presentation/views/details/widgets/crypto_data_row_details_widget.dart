import 'package:flutter/material.dart';

class CryptoDataRowDetailsWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const CryptoDataRowDetailsWidget({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = Colors.deepPurpleAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
