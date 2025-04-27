import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:flutter/material.dart';

class CryptoNotificationsPage extends StatefulWidget {
  const CryptoNotificationsPage({super.key});

  @override
  State<CryptoNotificationsPage> createState() =>
      _CryptoNotificationsPageState();
}

class _CryptoNotificationsPageState extends State<CryptoNotificationsPage> {
  final Map<String, TextEditingController> _minPriceControllers = {};
  final Map<String, TextEditingController> _maxPriceControllers = {};

  @override
  void initState() {
    super.initState();
    for (var crypto in TickerUtils.names) {
      _minPriceControllers[crypto] = TextEditingController();
      _maxPriceControllers[crypto] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _minPriceControllers.values) {
      controller.dispose();
    }
    for (var controller in _maxPriceControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: TickerUtils.names.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final crypto = TickerUtils.names[index];

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        crypto,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
            },
          ),
        ),
      ],
    );
  }
}
