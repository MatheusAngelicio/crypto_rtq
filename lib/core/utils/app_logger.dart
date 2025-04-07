import 'dart:developer' as dev;

class AppLogger {
  static const String _prefix = '📊 [Binance]';

  static void info(String message) {
    _log('ℹ️ INFO', message, color: '\x1B[36m'); // cyan
  }

  static void success(String message) {
    _log('✅ SUCCESS', message, color: '\x1B[32m'); // green
  }

  static void warning(String message) {
    _log('⚠️ WARNING', message, color: '\x1B[33m'); // yellow
  }

  static void error(String message) {
    _log('🛑 ERROR', message, color: '\x1B[31m'); // red
  }

  static void _log(String level, String message, {String color = '\x1B[0m'}) {
    final resetColor = '\x1B[0m';
    final formatted = '$color$_prefix $level: $message$resetColor';
    dev.log(formatted);
  }
}
