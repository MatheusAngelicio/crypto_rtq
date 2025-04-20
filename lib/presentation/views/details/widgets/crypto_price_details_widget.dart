import 'package:crypto_rtq/core/utils/chart_util.dart';
import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:crypto_rtq/presentation/views/details/widgets/crypto_data_row_details_widget.dart';
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
    final lastPrice = double.tryParse(crypto.lastPrice) ?? 0;
    final highPrice = double.tryParse(crypto.highPrice) ?? 1;
    final lowPrice = double.tryParse(crypto.lowPrice) ?? 0;

    final isNegative = crypto.priceChangePercent.startsWith('-');
    final progress = (lastPrice - lowPrice) / (highPrice - lowPrice);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.currency_exchange, size: 20, color: Colors.amber),
                const SizedBox(width: 8),
                const Text(
                  'Crypto Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                Text('(Last 24hrs)', style: TextStyle(fontSize: 12)),
              ],
            ),

            const SizedBox(height: 16),

            CryptoDataRowDetailsWidget(
              label: 'Last Price',
              value: TickerUtils.formatPrice(
                priceStr: crypto.lastPrice,
                toBRL: isBRL,
              ),
            ),
            CryptoDataRowDetailsWidget(
              label: 'High Price',
              value: TickerUtils.formatPrice(
                priceStr: crypto.highPrice,
                toBRL: isBRL,
              ),
            ),
            CryptoDataRowDetailsWidget(
              label: 'Low Price',
              value: TickerUtils.formatPrice(
                priceStr: crypto.lowPrice,
                toBRL: isBRL,
              ),
            ),

            const SizedBox(height: 12),

            CryptoDataRowDetailsWidget(
              label: 'Change',
              value: '${isNegative ? "↓" : "↑"} ${crypto.priceChangePercent}%',
              valueColor: isNegative ? Colors.red : Colors.green,
            ),

            const SizedBox(height: 24),
            const Text(
              'Price Position',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 6),

            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, animatedProgress, _) {
                final barColor = ChartUtils.getBarColor(animatedProgress);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                colors: [
                                  barColor.withValues(alpha: .7),
                                  barColor,
                                ],
                              ),
                            ),
                            width:
                                MediaQuery.of(context).size.width *
                                0.7 *
                                animatedProgress,
                          ),
                        ),
                        Positioned(
                          left: (animatedProgress *
                                  MediaQuery.of(context).size.width *
                                  0.7)
                              .clamp(
                                0.0,
                                MediaQuery.of(context).size.width * 0.7,
                              ),
                          child: Transform.translate(
                            offset: const Offset(-12, -28),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                TickerUtils.formatPrice(
                                  priceStr: crypto.lastPrice,
                                  toBRL: isBRL,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Low: ${TickerUtils.formatPrice(priceStr: crypto.lowPrice, toBRL: isBRL)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'High: ${TickerUtils.formatPrice(priceStr: crypto.highPrice, toBRL: isBRL)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
