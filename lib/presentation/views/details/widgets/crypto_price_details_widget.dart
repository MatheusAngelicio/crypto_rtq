import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:flutter/material.dart';

class CryptoPriceDetailsWidget extends StatelessWidget {
  final CryptoDetailEntity crypto;
  final bool isBRL;

  const CryptoPriceDetailsWidget({
    super.key,
    required this.crypto,
    required this.isBRL,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Last Price: ${TickerUtils.formatPrice(priceStr: crypto.lastPrice, toBRL: isBRL)}',
        ),
        Text(
          'High Price: ${TickerUtils.formatPrice(priceStr: crypto.highPrice, toBRL: isBRL)}',
        ),
        Text(
          'Low Price: ${TickerUtils.formatPrice(priceStr: crypto.lowPrice, toBRL: isBRL)}',
        ),
        Text('Change: ${crypto.priceChangePercent}%'),
      ],
    );
  }
}
