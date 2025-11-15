import 'package:client/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/repositories/auth_local_repository.dart';
import 'auth/view/pages/signup_page.dart';
import 'core/Providers/app_initializer_provider.dart';
import 'core/Providers/current_user_notifier.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final repo = AuthLocalRepository.fromPrefs(prefs);

  runApp(
    ProviderScope(
      overrides: [
        authLocalRepositoryProvider.overrideWithValue(
          AsyncValue.data(repo),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInit = ref.watch(appInitializerProvider);
    final currentUser = ref.watch(currentUserProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Music App',
      theme: AppTheme.darkThemeMode,
      home: appInit.when(
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (e, st) => Scaffold(
          body: Center(child: Text('Error: $e')),
        ),
        data: (_) {
          // Initialization complete
          return currentUser == null ? const SignupPage() : const HomePage();
        },
      ),
    );
  }
}
