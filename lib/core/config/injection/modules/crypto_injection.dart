import 'package:crypto_rtq/core/network/dio_client.dart';
import 'package:crypto_rtq/data/datasources/crypto/crypto_datasource.dart';
import 'package:crypto_rtq/data/datasources/crypto/crypto_datasource_impl.dart';
import 'package:crypto_rtq/data/repositories/crypto_detail_repository_impl.dart';
import 'package:crypto_rtq/domain/repositories/crypto_detail_repository.dart';
import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_detail_usecase.dart';
import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_detail_usecase_impl.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_chart/crypto_chart_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_detail_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> cryptoRepositories = [
  RepositoryProvider<CryptoDetailDatasource>(
    create:
        (context) =>
            CryptoDetailDatasourceImpl(dioClient: context.read<DioClient>()),
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
];

List<BlocProvider> cryptoBlocs = [
  BlocProvider<CryptoDetailCubit>(
    create:
        (context) => CryptoDetailCubit(context.read<GetCryptoDetailUseCase>()),
  ),
  BlocProvider<CryptoChartCubit>(
    create:
        (context) => CryptoChartCubit(context.read<GetCryptoDetailUseCase>()),
  ),
];
