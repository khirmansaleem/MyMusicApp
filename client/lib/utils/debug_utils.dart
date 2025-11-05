import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> debugPrintSharedPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys();

  if (keys.isEmpty) {
    debugPrint('🧩 [PrefsDebug] No data found in SharedPreferences.');
    return;
  }

  debugPrint('📦 [PrefsDebug] SharedPreferences content START →');
  for (final key in keys) {
    debugPrint('➡️ $key = ${prefs.get(key)}');
  }
  debugPrint('📦 [PrefsDebug] SharedPreferences content END ←');
}
