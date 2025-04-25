import 'package:crypto_rtq/core/config/app_routes.dart';
import 'package:crypto_rtq/core/services/app_rates.dart';
import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/presentation/cubits/exchange_rate/exchange_rate_cubit.dart';
import 'package:crypto_rtq/presentation/cubits/exchange_rate/exchange_rate_state.dart';
import 'package:crypto_rtq/presentation/cubits/ticker/ticker_cubit.dart';
import 'package:crypto_rtq/presentation/cubits/ticker/ticker_state.dart';
import 'package:crypto_rtq/presentation/views/details/arguments/crypto_detail_arguments.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/currency_toggle_widget.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/price_card_widget.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/shimmer_price_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CryptoListPage extends StatefulWidget {
  final TickerCubit tickerCubit;
  final ExchangeRateCubit exchangeRateCubit;

  const CryptoListPage({
    super.key,
    required this.tickerCubit,
    required this.exchangeRateCubit,
  });

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TickerCubit, TickerState>(
      bloc: widget.tickerCubit,
      builder: (context, tickerState) {
        return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
          bloc: widget.exchangeRateCubit,
          builder: (context, exchangeRateState) {
            if (tickerState is TickerError) {
              return Center(child: Text('Error: ${tickerState.message}'));
            } else if (exchangeRateState is ExchangeRateError) {
              return Center(child: Text('Error: ${exchangeRateState.message}'));
            }

            if (tickerState is TickerLoading ||
                exchangeRateState is ExchangeRateLoading) {
              return const ShimmerPriceListWidget();
            }

            if (tickerState is TickerLoaded &&
                exchangeRateState is ExchangeRateLoaded) {
              final prices = tickerState.prices;
              final isBRL = tickerState.currency == 'BRL';

              AppRates.updateUsdBrl(double.parse(exchangeRateState.data.price));

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
    );
  }
}
