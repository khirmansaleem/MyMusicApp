import 'package:client/home/view/pages/upload_song_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/repositories/auth_local_repository.dart';
import 'auth/view/pages/signup_page.dart';
import 'auth/viewmodel/auth_viewmodel.dart';
import 'core/Providers/current_user_notifier.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ 1. Preload SharedPreferences synchronously
  final prefs = await SharedPreferences.getInstance();
  final repo = AuthLocalRepository.fromPrefs(prefs);

  // ✅ 2. Override the async provider with a ready instance
  runApp(
    ProviderScope(
      overrides: [
        authLocalRepositoryProvider.overrideWith((ref) async => repo),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_initializeApp);
  }

  Future<void> _initializeApp() async {
    final authNotifier = ref.read(authViewModelProvider.notifier);

    try {
      // ✅ 3. Now prefs are already ready, so this will be instant
      await authNotifier.initSharedPreferences();

      // ✅ 4. Try to restore user from token
      await authNotifier.getData();

      debugPrint('✅ User restoration attempted');
    } catch (e, st) {
      debugPrint('❌ Startup error: $e\n$st');
    } finally {
      setState(() => _initialized = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);

    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify Music App',
      theme: AppTheme.darkThemeMode,
      home: currentUser == null ? const SignupPage() : const UploadSongPage(),
    );
  }
}
