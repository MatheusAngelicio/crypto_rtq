import 'package:crypto_rtq/core/utils/coin_utils.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_detail_cubit.dart';
import 'package:crypto_rtq/presentation/blocs/crypto_detail/crypto_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoDetailPage extends StatefulWidget {
  final String symbol;

  const CryptoDetailPage({super.key, required this.symbol});

  @override
  State<CryptoDetailPage> createState() => _CryptoDetailPageState();
}

class _CryptoDetailPageState extends State<CryptoDetailPage> {
  @override
  void initState() {
    super.initState();

    final symbol = CoinUtils.getSymbolByName(widget.symbol).toUpperCase();
    context.read<CryptoDetailCubit>().load(symbol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.symbol.toUpperCase()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CryptoDetailCubit, CryptoDetailState>(
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
                  const SizedBox(height: 16),
                  Text('Last Price: ${crypto.lastPrice}'),
                  Text('High Price: ${crypto.highPrice}'),
                  Text('Low Price: ${crypto.lowPrice}'),
                  Text('Change: ${crypto.priceChangePercent}%'),
                  const SizedBox(height: 32),
                  Text(
                    'Chart',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  const Expanded(
                    child: Placeholder(color: Colors.cyan, strokeWidth: 2),
                  ),
                ],
              );
            }
            // estado inicial ou fallback
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
