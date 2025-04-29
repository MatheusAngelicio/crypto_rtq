import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardCryptoNotificationWidget extends StatelessWidget {
  const CardCryptoNotificationWidget({
    super.key,
    required this.crypto,
    required Map<String, TextEditingController> minPriceControllers,
    required Map<String, TextEditingController> maxPriceControllers,
  }) : _minPriceControllers = minPriceControllers,
       _maxPriceControllers = maxPriceControllers;

  final String crypto;
  final Map<String, TextEditingController> _minPriceControllers;
  final Map<String, TextEditingController> _maxPriceControllers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.amber),
                const SizedBox(width: 8),
                Text(
                  crypto.toUpperCase(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),
            Row(
              children: [
                Expanded(
                  child: _buildPriceTextField(
                    controller: _minPriceControllers[crypto],
                    label: 'Below',
                    prefixIcon: Icons.arrow_downward,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildPriceTextField(
                    controller: _maxPriceControllers[crypto],
                    label: 'Above',
                    prefixIcon: Icons.arrow_upward,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceTextField({
    required TextEditingController? controller,
    required String label,
    required IconData prefixIcon,
    required Color color,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,6}')),
      ],
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon, color: color),
        prefixText: '\$ ',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
    );
  }
}
