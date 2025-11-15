//Auth State Provider that:
//
// ✅ Stores both the token and user data.
// ✅ Knows whether a user is logged in or not.
// ✅ Automatically restores state on app restart.
// ✅ Keeps the app reactive (UI rebuilds when user logs in/out).
// never dispose off and provides us data whenever we asks for it.

import 'package:client/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  UserModel? build() {
    return null;
  }

  // whenever user login or restart the app we need to add the particular user
  void addUser(UserModel user) {
    state = user;
  }
}
