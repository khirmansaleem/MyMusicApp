import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'song_progress_providers.g.dart';

@riverpod
class SongPositionNotifier extends _$SongPositionNotifier {
  @override
  Duration build() => Duration.zero;

  void update(Duration value) => state = value;
}

@riverpod
class SongDurationNotifier extends _$SongDurationNotifier {
  @override
  Duration build() => Duration.zero;

  void update(Duration value) => state = value;
}
