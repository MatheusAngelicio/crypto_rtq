import 'package:crypto_rtq/core/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PriceCardWidget extends StatelessWidget {
  const PriceCardWidget({super.key, required this.name, required this.price});

  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () {
          final lowerSymbol = name.toLowerCase();
          context.pushNamed(
            AppRoutes.cryptoDetailName,
            pathParameters: {'symbol': lowerSymbol},
          );
        },
        leading: CircleAvatar(child: Text(name[0])),
        title: Text(name),
        subtitle: Text('\$ $price'),
      ),
    );
  }
}
