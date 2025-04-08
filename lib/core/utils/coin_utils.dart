import 'package:intl/intl.dart';

class CoinUtils {
  static final Map<String, String> _coinNames = {
    'btcusdt': 'Bitcoin',
    'ethusdt': 'Ethereum',
    'bnbusdt': 'BNB',
    'xrpusdt': 'XRP',
    'adausdt': 'Cardano',
    'dogeusdt': 'Dogecoin',
    'solusdt': 'Solana',
    'dotusdt': 'Polkadot',
    'maticusdt': 'Polygon',
    'ltcusdt': 'Litecoin',
  };

  static String getCoinName(String symbol) {
    return _coinNames[symbol.toLowerCase()] ?? symbol.toUpperCase();
  }

  static String formatPrice({
    required String priceStr,
    required double rate,
    bool toBRL = false,
  }) {
    final price = double.tryParse(priceStr) ?? 0;
    final converted = toBRL ? price * rate : price;

    final format = NumberFormat.currency(
      locale: toBRL ? 'pt_BR' : 'en_US',
      symbol: toBRL ? 'R\$' : '\$ ',
      decimalDigits: 2,
    );

    return format.format(converted);
  }
}
