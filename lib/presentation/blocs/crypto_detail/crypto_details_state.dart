import 'package:crypto_rtq/domain/entities/crypto_detail_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CryptoDetailsState extends Equatable {
  const CryptoDetailsState();

  @override
  List<Object?> get props => [];
}

class CryptoDetailInitial extends CryptoDetailsState {}

class CryptoDetailLoading extends CryptoDetailsState {}

class CryptoDetailLoaded extends CryptoDetailsState {
  final CryptoDetailEntity data;

  const CryptoDetailLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class CryptoDetailError extends CryptoDetailsState {
  final String message;

  const CryptoDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
