import 'package:crypto_rtq/core/config/app_routes.dart';
import 'package:crypto_rtq/core/services/app_rates.dart';
import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/presentation/blocs/exchange_rate/exchange_rate_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/exchange_rate/exchange_rate_state.dart';
import 'package:crypto_rtq/presentation/blocs/ticker/ticker_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/ticker/ticker_state.dart';
import 'package:crypto_rtq/presentation/views/details/arguments/crypto_detail_arguments.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/currency_toggle_widget.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/price_card_widget.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/shimmer_price_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TickerCubit _tickerCubit;
  late final ExchangeRateCubit _exchangeRateCubit;

  @override
  void initState() {
    super.initState();
    _exchangeRateCubit = context.read<ExchangeRateCubit>()..load('USDTBRL');
    _tickerCubit = context.read<TickerCubit>()..load(TickerUtils.symbols);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Prices'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.attach_money),
            onPressed: () {
              print("Dólar icon clicked");
              // Aqui você pode implementar a navegação ou lógica futura
            },
          ),
        ],
      ),
      body: BlocBuilder<TickerCubit, TickerState>(
        bloc: _tickerCubit,
        builder: (context, tickerState) {
          return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
            bloc: _exchangeRateCubit,
            builder: (context, exchangeRateState) {
              if (tickerState is TickerError) {
                return Center(child: Text('Error: ${tickerState.message}'));
              } else if (exchangeRateState is ExchangeRateError) {
                return Center(
                  child: Text('Error: ${exchangeRateState.message}'),
                );
              }

              if (tickerState is TickerLoading ||
                  exchangeRateState is ExchangeRateLoading) {
                return const ShimmerPriceListWidget();
              }

              if (tickerState is TickerLoaded &&
                  exchangeRateState is ExchangeRateLoaded) {
                final prices = tickerState.prices;
                final isBRL = tickerState.currency == 'BRL';

                AppRates.updateUsdBrl(
                  double.parse(exchangeRateState.data.price),
                );

                return Column(
                  children: [
                    CurrencyToggleWidget(
                      isBRL: isBRL,
                      onChanged:
                          (_) => context.read<TickerCubit>().toggleCurrency(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: prices.length,
                        itemBuilder: (context, index) {
                          final ticker = prices[index];
                          final convertedPrice = TickerUtils.formatPrice(
                            priceStr: ticker.price.toString(),
                            toBRL: isBRL,
                          );

                          return PriceCardWidget(
                            name: TickerUtils.getCoinName(ticker.symbol),
                            price: convertedPrice,
                            onTap: () {
                              context.pushNamed(
                                AppRoutes.cryptoDetailName,
                                extra: CryptoDetailArguments(
                                  tickerEntity: ticker,
                                  isBRL: isBRL,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
