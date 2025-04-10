import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CryptoDetailState extends Equatable {
  const CryptoDetailState();

  @override
  List<Object?> get props => [];
}

class CryptoDetailInitial extends CryptoDetailState {}

class CryptoDetailLoading extends CryptoDetailState {}

class CryptoDetailLoaded extends CryptoDetailState {
  final CryptoDetailEntity data;

  const CryptoDetailLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class CryptoDetailError extends CryptoDetailState {
  final String message;

  const CryptoDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
