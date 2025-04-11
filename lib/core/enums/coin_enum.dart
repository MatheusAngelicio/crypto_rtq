import 'package:collection/collection.dart';

enum CoinEnum {
  btcusdt('btcusdt', 'Bitcoin'),
  ethusdt('ethusdt', 'Ethereum'),
  bnbusdt('bnbusdt', 'BNB'),
  xrpusdt('xrpusdt', 'XRP'),
  adausdt('adausdt', 'Cardano'),
  dogeusdt('dogeusdt', 'Dogecoin'),
  solusdt('solusdt', 'Solana'),
  dotusdt('dotusdt', 'Polkadot'),
  ltcusdt('ltcusdt', 'Litecoin');

  final String symbol;
  final String name;

  const CoinEnum(this.symbol, this.name);

  static CoinEnum? fromSymbol(String symbol) {
    return CoinEnum.values.firstWhereOrNull(
      (coin) => coin.symbol.toLowerCase() == symbol.toLowerCase(),
    );
  }

  static CoinEnum? fromName(String name) {
    return CoinEnum.values.firstWhereOrNull(
      (coin) => coin.name.toLowerCase() == name.toLowerCase(),
    );
  }
}
