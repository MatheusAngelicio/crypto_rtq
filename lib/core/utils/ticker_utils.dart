import 'package:crypto_rtq/core/enums/ticker_enum.dart';
import 'package:intl/intl.dart';

class TickerUtils {
  static List<String> get symbols =>
      TickerEnum.values.map((e) => e.symbol).toList();

  static String getCoinName(String symbol) {
    return TickerEnum.fromSymbol(symbol)?.name ?? symbol.toUpperCase();
  }

  static String getSymbolByName(String name) {
    return TickerEnum.fromName(name)?.symbol ?? '';
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
