import 'package:flutter/material.dart';

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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              crypto,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minPriceControllers[crypto],
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Notify if below',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _maxPriceControllers[crypto],
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Notify if above',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
