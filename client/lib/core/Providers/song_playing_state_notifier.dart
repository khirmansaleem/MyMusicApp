import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'song_playing_state_notifier.g.dart';

@riverpod
class SongPlayStateNotifier extends _$SongPlayStateNotifier {
  @override
  bool build() => false; // default is not playing

  void setPlaying(bool value) => state = value;

  void toggle() => state = !state;
}
