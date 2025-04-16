import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_detail_usecase.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoDetailCubit extends Cubit<CryptoDetailState> {
  CryptoDetailCubit(this._getCryptoDetailUseCase)
    : super(CryptoDetailInitial());

  final GetCryptoDetailUseCase _getCryptoDetailUseCase;

  Future<void> load(String symbol) async {
    emit(CryptoDetailLoading());

    final result = await _getCryptoDetailUseCase.getDetail(symbol);

    result.fold(
      (failure) => emit(CryptoDetailError(failure.message)),
      (entity) => emit(CryptoDetailLoaded(entity)),
    );
  }

  void reset() {
    emit(CryptoDetailInitial());
  }
}
