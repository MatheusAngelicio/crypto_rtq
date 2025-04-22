import 'package:crypto_rtq/domain/entities/exchange_rate_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ExchangeRateState extends Equatable {
  const ExchangeRateState();

  @override
  List<Object?> get props => [];
}

class ExchangeRateInitial extends ExchangeRateState {}

class ExchangeRateLoading extends ExchangeRateState {}

class ExchangeRateLoaded extends ExchangeRateState {
  final ExchangeRateEntity data;

  const ExchangeRateLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class ExchangeRateError extends ExchangeRateState {
  final String message;

  const ExchangeRateError(this.message);

  @override
  List<Object?> get props => [message];
}
