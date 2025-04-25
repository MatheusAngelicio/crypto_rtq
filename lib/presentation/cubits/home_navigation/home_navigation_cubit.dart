import 'package:crypto_rtq/presentation/cubits/home_navigation/home_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit() : super(HomeNavigationState(currentIndex: 0));

  void changePage(int index) {
    emit(HomeNavigationState(currentIndex: index));
  }
}
