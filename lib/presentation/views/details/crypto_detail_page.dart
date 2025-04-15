import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/domain/entities/crypto_chart_entity.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_chart/crypto_chart_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_chart/crypto_chart_state.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_detail_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:crypto_rtq/presentation/views/details/arguments/crypto_detail_arguments.dart';
import 'package:crypto_rtq/presentation/views/details/widgets/crypto_price_details_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoDetailPage extends StatefulWidget {
  final CryptoDetailArguments arguments;

  const CryptoDetailPage({super.key, required this.arguments});

  @override
  State<CryptoDetailPage> createState() => _CryptoDetailPageState();
}

class _CryptoDetailPageState extends State<CryptoDetailPage> {
  late final CryptoDetailCubit _cryptoDetailCubit;
  late final CryptoChartCubit _cryptoChartCubit;

  late String symbol;
  String selectedInterval = '1h'; // Intervalo padrão

  @override
  void initState() {
    super.initState();
    symbol = widget.arguments.tickerEntity.symbol;
    _loadCryptoDetail();
  }

  void _loadCryptoDetail() {
    _cryptoDetailCubit = context.read<CryptoDetailCubit>()..load(symbol);
  }

  void _loadChartData() {
    _cryptoChartCubit =
        context.read<CryptoChartCubit>()..load(symbol, selectedInterval, 30);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TickerUtils.getCoinName(widget.arguments.tickerEntity.symbol),
        ),
        centerTitle: true,
      ),
      body: BlocListener<CryptoDetailCubit, CryptoDetailState>(
        bloc: _cryptoDetailCubit,
        listener: (context, state) {
          if (state is CryptoDetailLoaded || state is CryptoDetailError) {
            // Quando carregar ou der erro, chama o chart
            _loadChartData();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<CryptoDetailCubit, CryptoDetailState>(
            bloc: _cryptoDetailCubit,
            builder: (context, state) {
              if (state is CryptoDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CryptoDetailError) {
                return Center(child: Text('Error: ${state.message}'));
              }

              if (state is CryptoDetailLoaded) {
                final crypto = state.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CryptoPriceDetailsWidget(
                      crypto: crypto,
                      isBRL: widget.arguments.isBRL,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Chart',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: BlocBuilder<CryptoChartCubit, CryptoChartState>(
                        bloc: _cryptoChartCubit,
                        builder: (context, state) {
                          if (state is CryptoChartLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is CryptoChartError) {
                            return Center(
                              child: Text('Error: ${state.message}'),
                            );
                          }

                          if (state is CryptoChartLoaded) {
                            final data = state.chartData;

                            if (data.isEmpty) {
                              return const Center(
                                child: Text('No data available'),
                              );
                            }

                            return LineChart(
                              LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                    spots:
                                        data
                                            .map(
                                              (e) => FlSpot(
                                                e
                                                    .openTime
                                                    .millisecondsSinceEpoch
                                                    .toDouble(),
                                                e.close,
                                              ),
                                            )
                                            .toList(),
                                    isCurved: true,
                                    color: Colors.cyan,
                                    barWidth: 2,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(show: false),
                                  ),
                                ],
                                titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 22,
                                      interval: _getTimeInterval(data),
                                      getTitlesWidget: (value, meta) {
                                        final date =
                                            DateTime.fromMillisecondsSinceEpoch(
                                              value.toInt(),
                                            );
                                        return Text(
                                          '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
                                          style: const TextStyle(fontSize: 10),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: true),
                                  ),
                                ),
                                gridData: FlGridData(show: true),
                                borderData: FlBorderData(show: true),
                              ),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

double _getTimeInterval(List<CryptoChartEntity> data) {
  if (data.length < 2) return 1;
  final diff = data[1].openTime.difference(data[0].openTime).inMinutes;
  return data.first.openTime.millisecondsSinceEpoch.toDouble() +
      (diff * 60 * 1000);
}
