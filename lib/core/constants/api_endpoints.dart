class ApiEndpoints {
  static const String baseUrl = 'https://api.binance.com/api/v3';
  static const String wsUrl = 'wss://stream.binance.com:9443/ws';

  // HTTP endpoints
  static const String tickerDetail = '/ticker/24hr';
  static const String chartData = '/uiKlines';
  static const String tickerPrice = '/ticker/price';
}
