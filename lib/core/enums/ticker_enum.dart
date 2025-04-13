import 'package:collection/collection.dart';

enum TickerEnum {
  btcusdt('btcusdt', 'Bitcoin'),
  ethusdt('ethusdt', 'Ethereum'),
  bnbusdt('bnbusdt', 'BNB'),
  xrpusdt('xrpusdt', 'XRP'),
  adausdt('adausdt', 'Cardano'),
  dogeusdt('dogeusdt', 'Dogecoin'),
  solusdt('solusdt', 'Solana'),
  dotusdt('dotusdt', 'Polkadot'),
  ltcusdt('ltcusdt', 'Litecoin');

  final String symbol, name;

  const TickerEnum(this.symbol, this.name);

  static TickerEnum? fromSymbol(String symbol) {
    return TickerEnum.values.firstWhereOrNull(
      (coin) => coin.symbol.toLowerCase() == symbol.toLowerCase(),
    );
  }

  static TickerEnum? fromName(String name) {
    return TickerEnum.values.firstWhereOrNull(
      (coin) => coin.name.toLowerCase() == name.toLowerCase(),
    );
  }
}
