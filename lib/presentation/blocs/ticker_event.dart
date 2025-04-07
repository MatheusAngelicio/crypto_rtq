import 'package:crypto_rtq/domain/entities/ticker_entity.dart';

abstract class TickerEvent {}

class SubscribeToTickers extends TickerEvent {
  final List<String> symbols;

  SubscribeToTickers(this.symbols);
}

class TickerUpdated extends TickerEvent {
  final TickerEntity ticker;

  TickerUpdated(this.ticker);
}

class TickerErrorOccurred extends TickerEvent {
  final String message;

  TickerErrorOccurred(this.message);
}
