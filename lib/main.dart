import 'package:crypto_rtq/core/config/injection_container.dart';
import 'package:crypto_rtq/presentation/views/home_page.dart';
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
        home: const HomePage(),
      ),
    );
  }
}
