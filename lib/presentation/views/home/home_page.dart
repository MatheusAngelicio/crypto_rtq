import 'package:crypto_rtq/core/utils/coin_utils.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_state.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/currency_toggle_widget.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/price_card_widget.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/shimmer_price_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TickerCubit _tickerCubit;

  @override
  void initState() {
    super.initState();
    _tickerCubit = context.read<TickerCubit>()..load(CoinUtils.symbols);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Prices'), centerTitle: true),
      body: BlocBuilder<TickerCubit, TickerState>(
        bloc: _tickerCubit,
        builder: (context, state) {
          if (state is TickerLoading) {
            return const ShimmerPriceListWidget();
          }

          if (state is TickerError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is TickerLoaded) {
            final prices = state.prices;
            final isBRL = state.currency == 'BRL';

            return Column(
              children: [
                CurrencyToggleWidget(
                  isBRL: state.currency == 'BRL',
                  onChanged:
                      (_) => context.read<TickerCubit>().toggleCurrency(),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: prices.length,
                    itemBuilder: (context, index) {
                      final coin = prices[index];
                      final convertedPrice = CoinUtils.formatPrice(
                        priceStr: coin.price.toString(),
                        rate: 5.8, // futuro: obter da API
                        toBRL: isBRL,
                      );

                      return PriceCardWidget(
                        name: CoinUtils.getCoinName(coin.symbol),
                        price: convertedPrice,
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
