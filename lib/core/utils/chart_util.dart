import 'dart:ui';

import 'package:crypto_rtq/core/utils/currency_util.dart';
import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:flutter/material.dart';

class ChartUtils {
  static Color getTrendColor(List<CryptoChartEntity> data, bool isBRL) {
    if (data.isEmpty) return Colors.cyan;

    final firstValue = CurrencyUtils.convert(data.first.close, toBRL: isBRL);
    final lastValue = CurrencyUtils.convert(data.last.close, toBRL: isBRL);

    return lastValue >= firstValue ? Colors.green : Colors.red;
  }

  static Color getBarColor(double progress) {
    if (progress >= 0.75) {
      return Colors.red;
    } else if (progress >= 0.5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
