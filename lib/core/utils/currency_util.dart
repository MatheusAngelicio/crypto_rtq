import 'package:intl/intl.dart';

class CurrencyUtils {
  static const double rate = 5.8; // taxa fixa por enquanto

  static double convert(double value, {bool toBRL = false}) {
    return toBRL ? value * rate : value;
  }

  static String format({required double value, bool toBRL = false}) {
    final format = NumberFormat.currency(
      locale: toBRL ? 'pt_BR' : 'en_US',
      symbol: toBRL ? 'R\$' : '\$ ',
      decimalDigits: 2,
    );
    return format.format(value);
  }

  static String formatFromString({
    required String priceStr,
    bool toBRL = false,
  }) {
    final price = double.tryParse(priceStr) ?? 0;
    return format(value: price, toBRL: toBRL);
  }
}
