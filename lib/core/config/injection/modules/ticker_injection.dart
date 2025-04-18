import 'package:crypto_rtq/data/datasources/ticker/get_ticker_prices_stream_datasource.dart';
import 'package:crypto_rtq/data/datasources/ticker/get_ticker_prices_stream_datasource_impl.dart';
import 'package:crypto_rtq/data/repositories/get_ticker_prices_stream_repository_impl.dart';
import 'package:crypto_rtq/domain/repositories/get_ticker_prices_stream_repository.dart';
import 'package:crypto_rtq/domain/usecases/ticker/get_ticker_prices_stream_usecase_impl.dart';
import 'package:crypto_rtq/domain/usecases/ticker/get_ticker_prices_stream_usecase.dart';
import 'package:crypto_rtq/presentation/blocs/ticker/ticker_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> tickerRepositories = [
  RepositoryProvider<GetTickerPricesStreamDatasource>(
    create: (_) => GetTickerPricesStreamDatasourceImpl(),
  ),
  RepositoryProvider<GetTickerPricesStreamRepository>(
    create:
        (context) => GetTickerPricesStreamRepositoryImpl(
          datasource: context.read<GetTickerPricesStreamDatasource>(),
        ),
  ),
  RepositoryProvider<GetTickerPricesStreamUsecase>(
    create:
        (context) => GetTickerPricesStreamUsecaseImpl(
          repository: context.read<GetTickerPricesStreamRepository>(),
        ),
  ),
];

List<BlocProvider> tickerBlocs = [
  BlocProvider<TickerCubit>(
    create:
        (context) => TickerCubit(
          getPriceStreamUseCase: context.read<GetTickerPricesStreamUsecase>(),
        ),
  ),
];
