import 'package:equatable/equatable.dart';

abstract class TickerEvent extends Equatable {
  const TickerEvent();

  @override
  List<Object?> get props => [];
}

class GetPricesEvent extends TickerEvent {
  final List<String> symbols;

  const GetPricesEvent(this.symbols);

  @override
  List<Object?> get props => [symbols];
}

class SubscribeTickerEvent extends TickerEvent {
  final List<String> symbols;

  const SubscribeTickerEvent(this.symbols);

  @override
  List<Object?> get props => [symbols];
}
