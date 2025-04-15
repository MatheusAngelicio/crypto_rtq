class CryptoException implements Exception {
  final String message;
  CryptoException(this.message);

  @override
  String toString() => 'DataSourceException: $message';
}
