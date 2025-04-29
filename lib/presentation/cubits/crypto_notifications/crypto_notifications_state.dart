import 'package:flutter/widgets.dart';

class CryptoNotificationsState {
  final Map<String, TextEditingController> minControllers;
  final Map<String, TextEditingController> maxControllers;

  CryptoNotificationsState({
    required this.minControllers,
    required this.maxControllers,
  });
}
