import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_chart/crypto_chart_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_chart/crypto_chart_state.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_details_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_details_state.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_interval/crypto_interval_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_interval/crypto_interval_state.dart';
import 'package:crypto_rtq/presentation/views/details/arguments/crypto_detail_arguments.dart';
import 'package:crypto_rtq/presentation/views/details/widgets/crypto_chart_data_widget.dart';
import 'package:crypto_rtq/presentation/views/details/widgets/crypto_price_details_widget.dart';
import 'package:crypto_rtq/presentation/views/details/widgets/interval_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoDetailPage extends StatefulWidget {
  final CryptoDetailArguments arguments;

  const CryptoDetailPage({super.key, required this.arguments});

  @override
  State<CryptoDetailPage> createState() => _CryptoDetailPageState();
}

class _CryptoDetailPageState extends State<CryptoDetailPage> {
  late final CryptoDetailsCubit _cryptoDetailCubit;
  late final CryptoChartCubit _cryptoChartCubit;
  late final CryptoIntervalCubit _cryptoIntervalCubit;

  late String symbol;

  @override
  void initState() {
    super.initState();
    symbol = widget.arguments.tickerEntity.symbol;
    _cryptoDetailCubit = context.read<CryptoDetailsCubit>();
    _cryptoChartCubit = context.read<CryptoChartCubit>();
    _cryptoIntervalCubit = context.read<CryptoIntervalCubit>();
    _loadCryptoDetail();
  }

  @override
  void dispose() {
    _cryptoDetailCubit.reset();
    _cryptoChartCubit.reset();
    _cryptoIntervalCubit.reset();
    super.dispose();
  }

  void _loadCryptoDetail() {
    _cryptoDetailCubit.load(symbol);
  }

  void _loadChartData() {
    final intervalState = _cryptoIntervalCubit.state;
    _cryptoChartCubit.load(symbol, intervalState.interval);
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
      body: BlocListener<CryptoDetailsCubit, CryptoDetailsState>(
        bloc: _cryptoDetailCubit,
        listener: (context, state) {
          if (state is CryptoDetailLoaded || state is CryptoDetailError) {
            _loadChartData();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<CryptoDetailsCubit, CryptoDetailsState>(
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
                    BlocBuilder<CryptoIntervalCubit, CryptoIntervalState>(
                      bloc: _cryptoIntervalCubit,
                      builder: (context, intervalState) {
                        return IntervalSelectorWidget(
                          selectedInterval: intervalState.interval,
                          onIntervalSelected: (interval) {
                            _cryptoIntervalCubit.selectInterval(interval);
                            _loadChartData();
                          },
                        );
                      },
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
                            return CryptoChartDataWidget(
                              chartData: data,
                              isBRL: widget.arguments.isBRL,
                              interval: _cryptoIntervalCubit.state.interval,
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
