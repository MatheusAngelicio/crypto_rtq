class CoinUtils {
  static String getCoinName(String symbol) {
    switch (symbol.toLowerCase()) {
      case 'btcusdt':
        return 'Bitcoin';
      case 'ethusdt':
        return 'Ethereum';
      case 'bnbusdt':
        return 'BNB';
      case 'adausdt':
        return 'Cardano';
      default:
        return symbol.toUpperCase();
    }
  }
}
