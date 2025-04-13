import 'package:crypto_rtq/domain/entities/ticker_entity.dart';

class CryptoDetailArguments {
  final TickerEntity tickerEntity;
  final bool isBRL;

  CryptoDetailArguments({required this.tickerEntity, required this.isBRL});
}
