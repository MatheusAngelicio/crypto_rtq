import 'package:crypto_rtq/presentation/blocs/ticker_bloc.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_event.dart';
import 'package:crypto_rtq/presentation/blocs/ticker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<TickerBloc>().add(LoadTickers());
    context.read<TickerBloc>().add(
      const GetPricesEvent(['BTCUSDT', 'ETHUSDT']),
    );

    context.read<TickerBloc>().add(
      const SubscribeTickerEvent(['BTCUSDT', 'ETHUSDT']),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Prices')),
      body: BlocBuilder<TickerBloc, TickerState>(
        builder: (context, state) {
          if (state is TickerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TickerLoaded) {
            final btc = state.tickers.firstWhere((t) => t.symbol == 'BTCUSDT');
            final eth = state.tickers.firstWhere((t) => t.symbol == 'ETHUSDT');

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildPriceCard('Bitcoin', 'BTC', btc.price),
                  const SizedBox(height: 16),
                  _buildPriceCard('Ethereum', 'ETH', eth.price),
                ],
              ),
            );
          } else if (state is TickerError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPriceCard(String name, String symbol, double price) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(child: Text(symbol)),
        title: Text(name),
        subtitle: Text('\$${price.toStringAsFixed(2)}'),
      ),
    );
  }
}
