import 'package:crypto_rtq/core/network/dio_client.dart';
import 'package:crypto_rtq/data/datasources/crypto/crypto_datasource.dart';
import 'package:crypto_rtq/data/datasources/crypto/crypto_datasource_impl.dart';
import 'package:crypto_rtq/data/datasources/ticker/ticker_stream_datasource.dart';
import 'package:crypto_rtq/data/datasources/ticker/ticker_stream_datasource_impl.dart';
import 'package:crypto_rtq/data/repositories/crypto_detail_repository_impl.dart';
import 'package:crypto_rtq/data/repositories/ticker_repository_impl.dart';
import 'package:crypto_rtq/domain/repositories/crypto_detail_repository.dart';
import 'package:crypto_rtq/domain/repositories/ticker_repository.dart';
import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_detail_usecase.dart';
import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_detail_usecase_impl.dart';
import 'package:crypto_rtq/domain/usecases/ticker/get_price_stream_usecase_impl.dart';
import 'package:crypto_rtq/domain/usecases/ticker/get_prices_stream_usecase.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_detail_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/ticker/ticker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInjection extends StatelessWidget {
  final Widget child;

  const AppInjection({super.key, required this.child});

  // Melhorar esse DI
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // EXISTENTES
        RepositoryProvider<TickerStreamDatasource>(
          create: (_) => TickerStreamDatasourceImpl(),
        ),
        RepositoryProvider<TickerRepository>(
          create:
              (context) => TickerRepositoryImpl(
                datasource: context.read<TickerStreamDatasource>(),
              ),
        ),
        RepositoryProvider<GetPriceStreamUseCase>(
          create:
              (context) => GetPriceStreamUseCaseImpl(
                repository: context.read<TickerRepository>(),
              ),
        ),

        RepositoryProvider<DioClient>(create: (_) => DioClient()),
        RepositoryProvider<CryptoDetailDatasource>(
          create:
              (context) => CryptoDetailDatasourceImpl(
                dioClient: context.read<DioClient>(),
              ),
        ),
        RepositoryProvider<CryptoDetailRepository>(
          create:
              (context) => CryptoDetailRepositoryImpl(
                datasource: context.read<CryptoDetailDatasource>(),
              ),
        ),
        RepositoryProvider<GetCryptoDetailUseCase>(
          create:
              (context) => GetCryptoDetailUseCaseImpl(
                repository: context.read<CryptoDetailRepository>(),
              ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TickerCubit>(
            create:
                (context) => TickerCubit(context.read<GetPriceStreamUseCase>()),
          ),

          BlocProvider<CryptoDetailCubit>(
            create:
                (context) =>
                    CryptoDetailCubit(context.read<GetCryptoDetailUseCase>()),
          ),
        ],
        child: child,
      ),
    );
  }
}
