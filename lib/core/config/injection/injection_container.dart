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
        ...coreRepositories,
        ...cryptoRepositories,
        ...tickerRepositories,
      ],
      child: MultiBlocProvider(
        providers: [...cryptoBlocs, ...tickerBlocs],
        child: child,
      ),
    );
  }
}
