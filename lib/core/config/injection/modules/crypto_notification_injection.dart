import 'package:crypto_rtq/presentation/cubits/crypto_notifications/crypto_notifications_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> cryptoNotificationIjnection = [
  BlocProvider<CryptoNotificationsCubit>(
    create: (context) => CryptoNotificationsCubit(),
  ),
];
