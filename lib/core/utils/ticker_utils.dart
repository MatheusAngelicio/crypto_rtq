import 'package:crypto_rtq/core/enums/ticker_enum.dart';
import 'package:crypto_rtq/core/utils/currency_util.dart';

class TickerUtils {
  static List<String> get symbols =>
      TickerEnum.values.map((e) => e.symbol).toList();

  static String getCoinName(String symbol) {
    return TickerEnum.fromSymbol(symbol)?.name ?? '';
  }

  static String getSymbolByName(String name) {
    return TickerEnum.fromName(name)?.symbol ?? '';
  }

  static String formatPrice({required String priceStr, bool toBRL = false}) {
    return CurrencyUtils.formatFromString(priceStr: priceStr, toBRL: toBRL);
  }
}
