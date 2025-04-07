import 'package:equatable/equatable.dart';
import '../../../domain/entities/ticker_entity.dart';

abstract class TickerState extends Equatable {
  const TickerState();

  @override
  List<Object?> get props => [];
}

class TickerInitial extends TickerState {}

class TickerLoading extends TickerState {}

class TickerLoaded extends TickerState {
  final List<TickerEntity> prices;

  const TickerLoaded(this.prices);

  @override
  List<Object?> get props => [prices];
}

class TickerError extends TickerState {
  final String message;

  const TickerError(this.message);

  @override
  List<Object?> get props => [message];
}
