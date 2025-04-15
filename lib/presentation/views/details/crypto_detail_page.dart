import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_chart/crypto_chart_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_chart/crypto_chart_state.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_detail_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:crypto_rtq/presentation/views/details/arguments/crypto_detail_arguments.dart';
import 'package:crypto_rtq/presentation/views/details/widgets/crypto_chart_data_widget.dart';
import 'package:crypto_rtq/presentation/views/details/widgets/crypto_price_details_widget.dart';
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
  int selectedLimit = 30;

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
        context.read<CryptoChartCubit>()
          ..load(symbol, selectedInterval, selectedLimit);
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
                            return CryptoChartDataWidget(chartData: data);
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
