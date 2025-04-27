import 'package:crypto_rtq/core/enums/ticker_enum.dart';
import 'package:crypto_rtq/core/utils/currency_util.dart';

class TickerUtils {
  static List<String> get symbols =>
      TickerEnum.values.map((e) => e.symbol).toList();

  static List<String> get names =>
      TickerEnum.values.map((e) => e.name).toList();

  static String getCoinName(String symbol) {
    return TickerEnum.fromSymbol(symbol)?.name ?? '';
  }

  static String getSymbolByName(String name) {
    return TickerEnum.fromName(name)?.symbol ?? '';
  }

  static String formatPrice({required String priceStr, bool toBRL = false}) {
    final price = double.tryParse(priceStr) ?? 0;
    final converted = CurrencyUtils.convert(price, toBRL: toBRL);
    return CurrencyUtils.format(value: converted, toBRL: toBRL);
  }
}
