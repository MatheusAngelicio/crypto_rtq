import 'package:crypto_rtq/domain/usecases/crypto_detail/get_crypto_details_usecase.dart';
import 'package:crypto_rtq/presentation/cubits/crypto_detail/crypto_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoDetailsCubit extends Cubit<CryptoDetailsState> {
  final GetCryptoDetailsUseCase _getCryptoDetailUseCase;

  CryptoDetailsCubit({required GetCryptoDetailsUseCase getCryptoDetailUseCase})
    : _getCryptoDetailUseCase = getCryptoDetailUseCase,
      super(CryptoDetailInitial());

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
