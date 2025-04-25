import 'package:crypto_rtq/presentation/cubits/home_navigation/home_navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> homeNavigationBlocs = [
  BlocProvider<HomeNavigationCubit>(create: (context) => HomeNavigationCubit()),
];
