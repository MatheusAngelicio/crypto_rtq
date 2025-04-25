import 'package:crypto_rtq/core/utils/ticker_utils.dart';
import 'package:crypto_rtq/presentation/cubits/exchange_rate/exchange_rate_cubit.dart';
import 'package:crypto_rtq/presentation/cubits/home_navigation/home_navigation_cubit.dart';
import 'package:crypto_rtq/presentation/cubits/home_navigation/home_navigation_state.dart';
import 'package:crypto_rtq/presentation/cubits/ticker/ticker_cubit.dart';
import 'package:crypto_rtq/presentation/views/home/pages/crypto_list_page.dart';
import 'package:crypto_rtq/presentation/views/home/pages/crypto_notifications_page.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/custom_bottom_navigation_bar_item_widget.dart';
import 'package:crypto_rtq/presentation/views/home/widgets/dollar_rate_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeNavigationCubit _homeNavigationCubit;
  late final TickerCubit _tickerCubit;
  late final ExchangeRateCubit _exchangeRateCubit;

  @override
  void initState() {
    super.initState();
    _homeNavigationCubit = context.read<HomeNavigationCubit>();
    _exchangeRateCubit = context.read<ExchangeRateCubit>()..load('USDTBRL');
    _tickerCubit = context.read<TickerCubit>()..load(TickerUtils.symbols);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      CryptoListPage(
        tickerCubit: _tickerCubit,
        exchangeRateCubit: _exchangeRateCubit,
      ),
      const CryptoNotificationsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Prices'),
        centerTitle: true,
        actions: [
          BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
            bloc: _homeNavigationCubit,
            builder: (context, state) {
              return state.currentIndex == 0
                  ? IconButton(
                    icon: const Icon(Icons.attach_money),
                    onPressed:
                        () => showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (context) => DollarRateBottomSheet(),
                        ),
                  )
                  : SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
        bloc: _homeNavigationCubit,
        builder: (context, state) {
          return pages[state.currentIndex];
        },
      ),
      bottomNavigationBar:
          BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
            bloc: _homeNavigationCubit,
            builder: (context, state) {
              return BottomNavigationBar(
                currentIndex: state.currentIndex,
                onTap: (index) {
                  _homeNavigationCubit.changePage(index);
                },
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor: Colors.grey[500],
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                items: [
                  CustomBottomNavigationBarItem(
                    icon: Icons.currency_bitcoin,
                    label: 'Cryptos',
                    index: 0,
                    currentIndex: state.currentIndex,
                  ),
                  CustomBottomNavigationBarItem(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    index: 1,
                    currentIndex: state.currentIndex,
                  ),
                ],
              );
            },
          ),
    );
  }
}
