import 'package:crypto_rtq/core/network/dio_client.dart';
import 'package:crypto_rtq/data/datasources/exchange_rate/get_exchange_rate_datasource.dart';
import 'package:crypto_rtq/data/datasources/exchange_rate/get_exchange_rate_datasource_impl.dart';
import 'package:crypto_rtq/data/repositories/get_exchange_rate_repository_impl.dart';
import 'package:crypto_rtq/domain/repositories/get_exchange_rate_repository.dart';
import 'package:crypto_rtq/domain/usecases/exchange_rate/get_exchange_rate_usecase.dart';
import 'package:crypto_rtq/domain/usecases/exchange_rate/get_exchange_rate_usecase_impl.dart';
import 'package:crypto_rtq/presentation/blocs/exchange_rate/exchange_rate_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> exchangeRateInject = [
  RepositoryProvider<GetExchangeRateDatasource>(
    create:
        (context) =>
            GetExchangeRateDatasourceImpl(dioClient: context.read<DioClient>()),
  ),
  RepositoryProvider<GetExchangeRateRepository>(
    create:
        (context) => GetExchangeRateRepositoryImpl(
          datasource: context.read<GetExchangeRateDatasource>(),
        ),
  ),
  RepositoryProvider<GetExchangeRateUsecase>(
    create:
        (context) => GetExchangeRateUsecaseImpl(
          repository: context.read<GetExchangeRateRepository>(),
        ),
  ),
];

List<BlocProvider> exchangeRateBlocs = [
  BlocProvider<ExchangeRateCubit>(
    create:
        (context) => ExchangeRateCubit(
          getExchangeRateUsecase: context.read<GetExchangeRateUsecase>(),
        ),
  ),
];
