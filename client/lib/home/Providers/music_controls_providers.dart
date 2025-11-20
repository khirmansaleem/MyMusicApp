import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'music_controls_providers.g.dart';

@riverpod
class Shuffle extends _$Shuffle {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}

@riverpod
class Repeat extends _$Repeat {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}
