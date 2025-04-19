import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';
import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_detail_usecase.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_chart/crypto_chart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoChartCubit extends Cubit<CryptoChartState> {
  final GetCryptoDetailUseCase _getCryptoDetailUseCase;

  CryptoChartCubit({required GetCryptoDetailUseCase getCryptoDetailUseCase})
    : _getCryptoDetailUseCase = getCryptoDetailUseCase,
      super(CryptoChartInitial());

  Future<void> load(String symbol, ChartIntervalEnum interval) async {
    emit(CryptoChartLoading());

    final result = await _getCryptoDetailUseCase.getChartData(symbol, interval);

    result.fold(
      (failure) => emit(CryptoChartError(failure.message)),
      (chartData) => emit(CryptoChartLoaded(chartData)),
    );
  }

  void reset() {
    emit(CryptoChartInitial());
  }
}
