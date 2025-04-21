class AppRates {
  static double? usdBrl;

  static void updateUsdBrl(double? newRate) {
    if (newRate == null || newRate <= 0) {
      throw Exception('Invalid exchange rate received from API: $newRate');
    }
    usdBrl = newRate;
  }

  static double getRate() {
    if (usdBrl == null) {
      throw Exception('Exchange rate has not been loaded yet!');
    }
    return usdBrl!;
  }
}
