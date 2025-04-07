import 'package:intl/intl.dart';

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
