import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/viewmodel/auth_viewmodel.dart'; // <-- adjust path

final appInitializerProvider = FutureProvider<void>((ref) async {
  final authNotifier = ref.read(authViewModelProvider.notifier);

  // Initialize shared prefs (if needed)
  await authNotifier.initSharedPreferences();

  // Restore user / load from storage / validate token
  await authNotifier.getData();
});
