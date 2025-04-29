import 'package:crypto_rtq/core/config/injection/modules/crypto_notification_injection.dart';
import 'package:crypto_rtq/core/config/injection/modules/exchange_rate_injection.dart';
import 'package:crypto_rtq/core/config/injection/modules/home_navigation_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/core_injection.dart';
import 'modules/crypto_injection.dart';
import 'modules/ticker_injection.dart';

class AppInjection extends StatelessWidget {
  final Widget child;
  const AppInjection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ...coreInject,
        ...cryptoInject,
        ...tickerInject,
        ...exchangeRateInject,
      ],
      child: MultiBlocProvider(
        providers: [
          ...cryptoBlocs,
          ...tickerBlocs,
          ...exchangeRateBlocs,
          ...homeNavigationBlocs,
          ...cryptoNotificationIjnection,
        ],
        child: child,
      ),
    );
  }
}
