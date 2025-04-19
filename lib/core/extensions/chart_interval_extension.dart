import 'package:crypto_rtq/core/enums/chart_inverval_enum.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

extension ChartIntervalExtension on ChartIntervalEnum {
  /// Exibe label para os botões.
  String get label {
    switch (this) {
      case ChartIntervalEnum.hour1:
        return '1H';
      case ChartIntervalEnum.day1:
        return '1D';
      case ChartIntervalEnum.week1:
        return '1W';
      case ChartIntervalEnum.month1:
        return '1M';
    }
  }

  /// Define os candles da consulta que será enviado na API.
  String get apiValue {
    switch (this) {
      case ChartIntervalEnum.hour1:
        return '5m';
      case ChartIntervalEnum.day1:
        return '30m';
      case ChartIntervalEnum.week1:
        return '4h';
      case ChartIntervalEnum.month1:
        return '1d';
    }
  }

  /// Define o período de tempo que vai buscar.
  DateTime get startTime {
    final now = DateTime.now();
    switch (this) {
      case ChartIntervalEnum.hour1:
        return now.subtract(const Duration(hours: 1));
      case ChartIntervalEnum.day1:
        return now.subtract(const Duration(days: 1));
      case ChartIntervalEnum.week1:
        return now.subtract(const Duration(days: 7));
      case ChartIntervalEnum.month1:
        return DateTime(now.year, now.month - 1, now.day);
    }
  }

  /// Define o tempo final da consulta.
  DateTime get endTime => DateTime.now();

  DateTimeIntervalType get intervalType {
    switch (this) {
      case ChartIntervalEnum.hour1:
        return DateTimeIntervalType.minutes;
      case ChartIntervalEnum.day1:
        return DateTimeIntervalType.hours;
      case ChartIntervalEnum.week1:
      case ChartIntervalEnum.month1:
        return DateTimeIntervalType.days;
    }
  }

  DateFormat get dateFormat {
    switch (this) {
      case ChartIntervalEnum.hour1:
      case ChartIntervalEnum.day1:
        return DateFormat.Hm(); // Ex: 12:45
      case ChartIntervalEnum.week1:
      case ChartIntervalEnum.month1:
        return DateFormat.MMMd(); // Ex: Apr 16
    }
  }
}
