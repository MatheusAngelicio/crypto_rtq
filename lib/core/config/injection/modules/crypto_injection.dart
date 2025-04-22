import 'package:crypto_rtq/core/network/dio_client.dart';
import 'package:crypto_rtq/data/datasources/crypto/get_crypto_details_datasource.dart';
import 'package:crypto_rtq/data/datasources/crypto/get_crypto_details_datasource_impl.dart';
import 'package:crypto_rtq/data/repositories/get_crypto_details_repository_impl.dart';
import 'package:crypto_rtq/domain/repositories/get_crypto_details_repository.dart';
import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_details_usecase.dart';
import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_details_usecase_impl.dart';
import 'package:crypto_rtq/presentation/cubits/crypto_chart/crypto_chart_cubit.dart';
import 'package:crypto_rtq/presentation/cubits/crypto_detail/crypto_details_cubit.dart';
import 'package:crypto_rtq/presentation/cubits/crypto_interval/crypto_interval_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> cryptoInject = [
  RepositoryProvider<GetCryptoDetailsDatasource>(
    create:
        (context) => GetCryptoDetailsDatasourceImpl(
          dioClient: context.read<DioClient>(),
        ),
  ),

  RepositoryProvider<GetCryptoDetailsRepository>(
    create:
        (context) => GetCryptoDetailsRepositoryImpl(
          datasource: context.read<GetCryptoDetailsDatasource>(),
        ),
  ),

  RepositoryProvider<GetCryptoDetailsUseCase>(
    create:
        (context) => GetCryptoDetaislUseCaseImpl(
          repository: context.read<GetCryptoDetailsRepository>(),
        ),
  ),
];

List<BlocProvider> cryptoBlocs = [
  BlocProvider<CryptoDetailsCubit>(
    create:
        (context) => CryptoDetailsCubit(
          getCryptoDetailUseCase: context.read<GetCryptoDetailsUseCase>(),
        ),
  ),

  BlocProvider<CryptoChartCubit>(
    create:
        (context) => CryptoChartCubit(
          getCryptoDetailUseCase: context.read<GetCryptoDetailsUseCase>(),
        ),
  ),

  BlocProvider<CryptoIntervalCubit>(create: (context) => CryptoIntervalCubit()),
];
