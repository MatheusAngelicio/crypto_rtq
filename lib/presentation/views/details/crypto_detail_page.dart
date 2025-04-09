import 'package:flutter/material.dart';

class CryptoDetailPage extends StatelessWidget {
  final String symbol;

  const CryptoDetailPage({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(symbol.toUpperCase()), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crypto Details',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Placeholder(
              fallbackHeight: 100,
              color: Colors.amber,
              strokeWidth: 2,
            ),
            const SizedBox(height: 32),
            Text('Chart', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const Expanded(
              child: Placeholder(color: Colors.cyan, strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}
