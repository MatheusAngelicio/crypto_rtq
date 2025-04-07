import 'package:crypto_rtq/core/utils/coin_utils.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_state.dart';
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

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: prices.length,
              itemBuilder: (context, index) {
                final coin = prices[index];
                return _buildPriceCard(
                  CoinUtils.getCoinName(coin.symbol),
                  coin.symbol.toUpperCase(),
                  coin.price,
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPriceCard(String name, String symbol, double price) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(child: Text(symbol[0])),
        title: Text(name),
        subtitle: Text('\$${price.toStringAsFixed(2)}'),
      ),
    );
  }
}
