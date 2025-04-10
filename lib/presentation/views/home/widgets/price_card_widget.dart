import 'package:flutter/material.dart';

class PriceCardWidget extends StatelessWidget {
  const PriceCardWidget({
    super.key,
    required this.name,
    required this.price,
    required this.onTap,
  });

  final String name, price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(child: Text(name[0])),
        title: Text(name),
        subtitle: Text('\$ $price'),
      ),
    );
  }
}
