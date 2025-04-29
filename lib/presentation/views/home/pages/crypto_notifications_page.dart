import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/presentation/cubits/crypto_notifications/crypto_notifications_cubit.dart';
import 'package:crypto_rtq/presentation/cubits/crypto_notifications/crypto_notifications_state.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/card_crypto_notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoNotificationsPage extends StatelessWidget {
  const CryptoNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoNotificationsCubit, CryptoNotificationsState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: TickerUtils.names.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final crypto = TickerUtils.names[index];
                  return CardCryptoNotificationWidget(
                    crypto: crypto,
                    minPriceControllers: state.minControllers,
                    maxPriceControllers: state.maxControllers,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
