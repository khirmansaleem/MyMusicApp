import 'dart:async';

import 'package:client/auth/model/user_model.dart';
import 'package:client/auth/repositories/auth_local_repository.dart';
import 'package:client/core/Providers/current_user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Left, Right;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/debug_utils.dart';
import '../repositories/auth_remote_repository.dart';

part 'auth_viewmodel.g.dart';

//AsyncValue<T> is a special data type that represents asynchronous state
// — i.e., a value that can be loading, successful, or error.
//-------------------------------------------------------------------
// the value return by this before logging in or sign up will be null
// but once the user logged in or register value will be updated.
//--------------------------------------------------------------------
// return userModel data here
// AuthviewModel is simply meant for deciding what authentication state to be
// displayed on UI AND communicate with repository and
// so UI does not have to directly communicate with repository
@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late CurrentUserNotifier _currentUserNotifier;

  //a wrapper async value that might contain your repository later.
  AsyncValue<AuthLocalRepository>? _authLocalRepository;

// build method instantiate dependencies related to AuthViewModel class.
  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.read(authRemoteRepositoryProvider);
    _authLocalRepository = ref.read(authLocalRepositoryProvider);
    _currentUserNotifier = ref.read(currentUserProvider.notifier);
    return null;
  }

  // initialize shared preferences local database here

  Future<void> initSharedPreferences() async {
    //await _authLocalRepository.init();
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    // using async we are returning loading, error and successful states.
    //------------------------------------------------------------
    //first state when user comes this page is loading indicator
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }

  //----------------------------------------------------------------------
  Future<void> LoginUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    res.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (user) async {
        await _loginSuccess(user); // ✅ await it
      },
    );
  }

  Future<AsyncValue<UserModel>?> _loginSuccess(UserModel user) async {
    try {
      // ✅ Wait until SharedPreferences is ready (not loading)
      final repo = await ref.read(authLocalRepositoryProvider.future);
      await repo.setToken(user.token);

      debugPrint('💾 [AuthDebug] Token saved persistently: ${user.token}');
      await debugPrintSharedPrefs();

      // ✅ Add user only after token is stored
      _currentUserNotifier.addUser(user);
      state = AsyncValue.data(user);

      debugPrint('✅ [AuthDebug] Login success, state updated');
      return state;
    } catch (e, st) {
      debugPrint('❌ [AuthDebug] Error saving token: $e\n$st');
      state = AsyncValue.error(e.toString(), st);
      return state;
    }
  }

// get token from shared_preference
// based on the token send a request to server requesting user data.
// on the server side, decode that token
// get user_id and from that id get user data from postgresql database.
// FOR USER STATE PERSISTENCE

  Future<UserModel?> getData() async {
    // we fetch the data only when user restarts the application.
    //------------------------------------------------------------
    state = const AsyncValue.loading();
    // it gives innerData of async value or null
    // if it is still loading or error.
    final repo = await ref.read(authLocalRepositoryProvider.future);
    final token = repo.getToken();
    debugPrint(
        '🔐 Inside getDATA [AuthDebug] Stored token: ${repo.getToken()}');
    unawaited(debugPrintSharedPrefs()); // optional: print full prefs content

    if (token != null) {
      // send a request to server to get user data by token
      final res = await _authRemoteRepository.getCurrentUserData(token: token);
      final val = switch (res) {
        Left(value: final l) => state =
            AsyncValue.error(l.message, StackTrace.current),
        Right(value: final r) => _getDataSuccess(r),
      };

      return val.value;
    }
    return null;
  }

// get User data success when restarting applicaiotn
  AsyncValue<UserModel> _getDataSuccess(UserModel user) {
    // updating the currentUserNotifier to add the user
    // and returning the state of the user.

    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}
