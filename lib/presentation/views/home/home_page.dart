import 'package:crypto_rtq/core/utils/coin_utils.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_state.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/price_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> symbols = ['btcusdt', 'ethusdt'];

  @override
  void initState() {
    super.initState();
    context.read<TickerCubit>().load(symbols);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Prices'), centerTitle: true),
      body: BlocBuilder<TickerCubit, TickerState>(
        builder: (context, state) {
          if (state is TickerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TickerError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is TickerLoaded) {
            final prices = state.prices;
            final isBRL = state.currency == 'BRL';

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('USD'),
                      Switch(
                        value: isBRL,
                        onChanged:
                            (_) => context.read<TickerCubit>().toggleCurrency(),
                      ),
                      const Text('BRL'),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: prices.length,
                    itemBuilder: (context, index) {
                      final coin = prices[index];
                      final convertedPrice = CoinUtils.formatPrice(
                        priceStr: coin.price.toString(),
                        rate: 5.8, // Talvez pegar de uma api
                        toBRL: isBRL,
                      );

                      return PriceCardWidget(
                        name: CoinUtils.getCoinName(coin.symbol),
                        symbol: coin.symbol.toUpperCase(),
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
