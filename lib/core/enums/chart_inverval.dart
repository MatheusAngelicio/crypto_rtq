enum ChartInterval {
  second1,
  minute1,
  minute3,
  minute5,
  minute15,
  minute30,
  hour1,
  hour2,
  hour4,
  hour6,
  hour8,
  hour12,
  day1,
  day3,
  week1,
  month1,
}

extension ChartIntervalExtension on ChartInterval {
  String get apiValue {
    switch (this) {
      case ChartInterval.second1:
        return '1s';
      case ChartInterval.minute1:
        return '1m';
      case ChartInterval.minute3:
        return '3m';
      case ChartInterval.minute5:
        return '5m';
      case ChartInterval.minute15:
        return '15m';
      case ChartInterval.minute30:
        return '30m';
      case ChartInterval.hour1:
        return '1h';
      case ChartInterval.hour2:
        return '2h';
      case ChartInterval.hour4:
        return '4h';
      case ChartInterval.hour6:
        return '6h';
      case ChartInterval.hour8:
        return '8h';
      case ChartInterval.hour12:
        return '12h';
      case ChartInterval.day1:
        return '1d';
      case ChartInterval.day3:
        return '3d';
      case ChartInterval.week1:
        return '1w';
      case ChartInterval.month1:
        return '1M';
    }
  }
}
