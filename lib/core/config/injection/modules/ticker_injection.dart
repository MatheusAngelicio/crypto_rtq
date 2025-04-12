import 'package:crypto_rtq/data/datasources/ticker/ticker_stream_datasource.dart';
import 'package:crypto_rtq/data/datasources/ticker/ticker_stream_datasource_impl.dart';
import 'package:crypto_rtq/data/repositories/ticker_repository_impl.dart';
import 'package:crypto_rtq/domain/repositories/ticker_repository.dart';
import 'package:crypto_rtq/domain/usecases/ticker/get_price_stream_usecase_impl.dart';
import 'package:crypto_rtq/domain/usecases/ticker/get_prices_stream_usecase.dart';
import 'package:crypto_rtq/presentation/blocs/ticker/ticker_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> tickerRepositories = [
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
];

List<BlocProvider> tickerBlocs = [
  BlocProvider<TickerCubit>(
    create: (context) => TickerCubit(context.read<GetPriceStreamUseCase>()),
  ),
];
