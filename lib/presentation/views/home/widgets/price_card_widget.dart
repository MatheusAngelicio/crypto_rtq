import 'package:flutter/material.dart';

class PriceCardWidget extends StatelessWidget {
  const PriceCardWidget({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
  });

  final String name, symbol, price;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(child: Text(symbol[0])),
        title: Text(name),
        subtitle: Text(price),
      ),
    );
  }
}
