import 'package:crypto_rtq/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> coreRepositories = [
  RepositoryProvider<DioClient>(create: (_) => DioClient()),
];
