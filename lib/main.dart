import 'package:crypto_rtq/core/config/injection_container.dart';
import 'package:crypto_rtq/data/datasources/binance_datasource.dart';
import 'package:crypto_rtq/data/repositories/ticker_repository_impl.dart';
import 'package:crypto_rtq/domain/usecases/get_prices_usecase.dart';
import 'package:crypto_rtq/domain/usecases/subscribe_ticker_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppInjection(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Watch',
        theme: ThemeData.dark(),
        //home: const HomePage(),
      ),
    );
  }
}
