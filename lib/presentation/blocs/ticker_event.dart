import 'package:equatable/equatable.dart';

abstract class TickerEvent extends Equatable {
  const TickerEvent();

  @override
  List<Object?> get props => [];
}

class LoadTickers extends TickerEvent {}

class SubscribeToTicker extends TickerEvent {
  final String symbol;

  const SubscribeToTicker(this.symbol);

  @override
  List<Object?> get props => [symbol];
}
