import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CryptoChartState extends Equatable {
  const CryptoChartState();

  @override
  List<Object?> get props => [];
}

class CryptoChartInitial extends CryptoChartState {}

class CryptoChartLoading extends CryptoChartState {}

class CryptoChartLoaded extends CryptoChartState {
  final List<CryptoChartEntity> chartData;

  const CryptoChartLoaded(this.chartData);

  @override
  List<Object?> get props => [chartData];
}

class CryptoChartError extends CryptoChartState {
  final String message;

  const CryptoChartError(this.message);

  @override
  List<Object?> get props => [message];
}
