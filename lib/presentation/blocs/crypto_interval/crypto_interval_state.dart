class CryptoIntervalState {
  final String interval;
  final int limit;

  const CryptoIntervalState({required this.interval, required this.limit});

  CryptoIntervalState copyWith({String? interval, int? limit}) {
    return CryptoIntervalState(
      interval: interval ?? this.interval,
      limit: limit ?? this.limit,
    );
  }
}
