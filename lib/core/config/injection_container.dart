import 'package:crypto_rtq/data/datasources/ticker_stream_datasource.dart';
import 'package:crypto_rtq/data/datasources/ticker_stream_datasource_impl.dart';
import 'package:crypto_rtq/data/repositories/ticker_repository_impl.dart';
import 'package:crypto_rtq/domain/repositories/ticker_repository.dart';
import 'package:crypto_rtq/domain/usecases/get_prices_stream_usecase.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInjection extends StatelessWidget {
  final Widget child;

  const AppInjection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TickerStreamDatasource>(
          create: (_) => TickerStreamDatasourceImpl(),
        ),

        RepositoryProvider<TickerRepository>(
          create:
              (context) => TickerRepositoryImpl(
                streamDatasource: context.read<TickerStreamDatasource>(),
              ),
        ),

        RepositoryProvider<GetPriceStreamUseCase>(
          create:
              (context) =>
                  GetPriceStreamUseCase(context.read<TickerRepository>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TickerBloc>(
            create:
                (context) => TickerBloc(context.read<GetPriceStreamUseCase>()),
          ),
        ],
        child: child,
      ),
    );
  }
}
