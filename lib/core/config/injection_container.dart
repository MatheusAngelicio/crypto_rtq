import 'package:crypto_rtq/core/config/api_config.dart';
import 'package:crypto_rtq/data/datasources/binance_datasource.dart';
import 'package:crypto_rtq/data/repositories/ticker_repository_impl.dart';
import 'package:crypto_rtq/domain/repositories/ticker_repository.dart';
import 'package:crypto_rtq/domain/usecases/get_prices_usecase.dart';
import 'package:crypto_rtq/domain/usecases/subscribe_ticker_usecase.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class AppInjection extends StatelessWidget {
  final Widget child;

  const AppInjection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Dio>(
          create: (_) => Dio(BaseOptions(baseUrl: ApiConfig.baseUrl)),
        ),
        RepositoryProvider<BinanceDatasource>(
          create: (context) => BinanceDatasource(context.read<Dio>()),
        ),
        RepositoryProvider<TickerRepository>(
          create:
              (context) =>
                  TickerRepositoryImpl(context.read<BinanceDatasource>()),
        ),
        RepositoryProvider<GetPricesUseCase>(
          create:
              (context) => GetPricesUseCase(context.read<TickerRepository>()),
        ),
        RepositoryProvider<SubscribeTickerUseCase>(
          create:
              (context) =>
                  SubscribeTickerUseCase(context.read<TickerRepository>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TickerBloc>(
            create:
                (context) => TickerBloc(
                  getPrices: context.read<GetPricesUseCase>(),
                  subscribeTicker: context.read<SubscribeTickerUseCase>(),
                ),
          ),
        ],
        child: child,
      ),
    );
  }
}
